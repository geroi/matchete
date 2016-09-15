class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :prepare_meta_tags, if: "request.get?"
  before_filter :authenticate_user!
  # protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  layout 'inspinia'
  def current_player
    if current_user
      current_player = current_user.player
    else
      nil
    end
  end

  protected
    def render_json(json, options={})
      callback, variable = params[:callback], params[:variable]
      response = begin
        if callback && variable
          "var #{variable} = #{json};n#{callback}(#{variable});"
        elsif variable
          "var #{variable} = #{json};"
        elsif callback
          "#{callback}(#{json});"
        else
          json
        end
      end
      render({:content_type => 'application/javascript', :text => response}.merge(options))
    end
  # def after_sign_in_path_for user
  #   current_user_path
  # end

  # def after_sign_out_path_for user
  #   request.referer
  # end

  def prepare_meta_tags(options={})
    site_name   = "MATCHETE"
    title       = [controller_name, action_name].join(" ")
    description = "The Matchete helps you to find a sports partner or even team"
    image       = options[:image] || nil
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        'MATCHETE',
      title:       'Matchete - find a partner for you match',
      image:       'player.jpg',
      description: 'description',
      keywords:    %w[sport app matchete companion sparring football basketball rugby],
      # twitter: {
      #   site_name: site_name,
      #   site: '@thecookieshq',
      #   card: 'summary',
      #   description: description,
      #   image: image
      # },
      # og: {
      #   url: current_url,
      #   site_name: site_name,
      #   title: title,
      #   image: image,
      #   description: description,
      #   type: 'website'
      # }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end

end
