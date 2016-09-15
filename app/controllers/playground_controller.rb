class PlaygroundController < ApplicationController
	
	def show
		@playground = Playground.find_by_id(params[:id])
	end

	def fetch_playgrounds
		bbox_match_ary = params[:bbox].match(/(\d+\.\d+),(\d+\.\d+),(\d+\.\d+),(\d+\.\d+)/)
		a = bbox_match_ary[1]
		b = bbox_match_ary[2]
		c = bbox_match_ary[3]
		d = bbox_match_ary[4]
		
		bbox_coords = [a,b,c,d]
		callback_name = params[:callback]

		tiles_match_ary = params[:tiles].match(/(\d+),(\d+),(\d+),(\d+)/)
		tile = [tiles_match_ary[1],tiles_match_ary[2]]
		
		z = params[:zoom]

		
		playgrounds_cache = Rails.cache.fetch "tile-#{tile[0]}-#{tile[1]}-#{z}" do 
			
			playgrounds = Playground.where('(latitude > ? AND latitude < ? ) AND (longitude > ? AND longitude < ?)', a, c, b, d)
			
			ya_response = {
				"type": "FeatureCollection",
  				"features": []
  			}
			
			playgrounds.each do |playground|

			balloonContentHeader = <<HTML
<div class='row'>
    <div class='col-md-4'>
        <a href='#{playground.id}'>
            <span class="glyphicon glyphicon-record"></span>
        </a>
    </div>
    <div class='col-md-8'>
        <a href='/playgrounds/#{playground.id}'>
            <p>
                <strong>#{playground.name}</strong>
            </p>
        </a>
    </div>
</div>
HTML

			balloonContent = <<HTML
<div class='row'>
<div class='col-md-12'>
    <h5>#{playground.facility_type}</h5>
    <h5>#{playground.address}</h5>
    <h5>#{playground.adm_area}</h5>
    <h5>#{playground.district}</h5>
</div>
</div>
HTML
			balloonContentFooter = <<HTML
<div class='row'>
    <div class='col-md-12'>
        <a href='/playgrounds/#{playground.id}' class='btn btn-default pull-right'><span class='glyphicon glyphicon-eye-open'>Смотреть</span></a>
    </div>
</div>
HTML
				feature = {
					"type": "Feature",
				     "id": playground.id,
				      "geometry": {
				        "type": "Point",
				        "coordinates": [playground.latitude, playground.longitude]
				      },
				      "properties": {
				        "balloonContentHeader": balloonContentHeader,
				        "balloonContent": balloonContent,
				        "balloonContentFooter": balloonContentFooter,
				        "hintContent": playground.facility_type
				      }
				}

				ya_response[:"features"].push feature
			end
			ya_response
		end

		render_json playgrounds_cache.to_json
	end
end