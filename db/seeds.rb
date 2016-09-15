# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def get_bool_from text
  if text == 'да'
    true
  else
    false
  end
end

require 'json'
file = Rails.root.join('misc','sportgrounds.json')
json_ary = JSON.parse(open(file).read)

json_ary = json_ary.slice(0,100) # УДАЛИТЬ ЭТУ СТРОКУ ДЛЯ ПОЛНОТЫ БАЗЫ

json_ary.each{|element|
  place = Playground.new({
    hash_id: element['Id'],
    latitude: element['Lat'],
    longitude: element['Lon'],
    name: element['Cells']['ObjectShortName'],
    photo: element['Cells']['Photo'].to_s.gsub(/\[|\]|\"/,''),
    address: element['Cells']['Address'],
    lighting: element['Cells']['SportZoneLighting'],
    adm_area:  element['Cells']['AdmArea'].to_s.gsub(/\[|\]/,''),
    email: element['Cells']['Email'],
    facility_type: element['Cells']['FacilityType'],
    district: element['Cells']['District'].to_s.gsub(/\[|\]/,''),
    website: element['Cells']['WebSite'],
    phone: element['Cells']['HelpPhone'],
    has_rental: get_bool_from(element['Cells']['ObjectHasEquipmentRental']),
    has_dressing_room: get_bool_from(element['Cells']['ObjectHasDressingRoom']),
    has_toilet: get_bool_from(element['Cells']['ObjectHasToilet']),
    has_first_aid: get_bool_from(element['Cells']['ObjectHasFirstAidPost'])
    })
  place.save!
}

types_ary = ['Футбол',
            'Баскетбол',
            'Регби',
            'Волейбол',
            'Хоккей',
            'Американский футбол',
            'Бейсбол',
            'Водное поло',
            'Лакросс'
          ]
types_logos_ary = %W(football basketball rugby volleyball hockey american-football baseball waterpolo lacrosse)
types_ary.each_with_index {|type_name, index| 
  type_logo = File.open(Rails.root.join('misc','type_logos',"#{types_logos_ary[index]}.png"))
  Type.create(name: type_name, logo: type_logo)}

users_ary = %W(Alexander Alexey Roman Joe Jay Rocky)

10.times do 
  users_ary.push Faker::Name.first_name
end 
users_ary.each {|user_name|  User.create(email: "#{user_name.downcase}@mail.ru", password: "wpww1488", password_confirmation: "wpww1488") }


Player.all.each do |player|
  # avatar_url = JSON.parse(RestClient.get('http://uifaces.com/api/v1/random'))["image_urls"]["epic"]
  # player.update(avatar: open(avatar_url))
  avatar_url = File.open(Rails.root.join('misc','avatars',"#{rand(1..15)}.jpg"))
  player.update(avatar: open(avatar_url))
end

20.times do 
  name = "Simple Game \##{rand 100}"
  player_id = Random.rand(1..users_ary.length)
  game_date_time = (Date.today-1.month) + rand(60).day
  playground_id = Random.rand(1..100)
  type_id = Random.rand(1..4)
  Game.create(name: name, player_id: player_id, game_date_time: game_date_time, playground_id: playground_id, type_id: type_id, individual: true)
end


Player.find(1).invite_friend Player.find(2)
Player.find(1).invite_friend Player.find(3)
Player.find(2).approve_invitation_from Player.find(1)
Player.find(4).invite_friend Player.find(1)

team1_logo = File.open(Rails.root.join('misc','default_team_logo.gif'))
team2_logo = File.open(Rails.root.join('misc','lakers.jpg'))
foot_team = Team.create(name:'FOOTBALLTEAM', type_id:1, host_id: 1, logo: team1_logo, address: 'г. Королев, Московская область')

color_palette = %W( #FFEB3B #E91E63 #E040FB #40C4FF #FF3D00 #f44336 #673AB7 #2196F3 #4CAF50 #CDDC39 #FF5722 #795548 #9E9E9E #607D8B )
3.times do
  foot_team.add_color color_palette[rand(0...color_palette.length)]
end


basket_team = Team.create(name:'BASKETTEAM', type_id:2, host_id: 2, logo: team2_logo, address: 'Химки, Москва')
3.times do
  basket_team.add_color color_palette[rand(0...color_palette.length)]
end

foot_team.invite_teammate(Player.find(2))
foot_team.invite_teammate(Player.find(3))
foot_team.invite_teammate(Player.find(4))
foot_team.delete_teammate(Player.find(3))
Player.find(2).approve_team_invitation_from foot_team
Player.find(5).claim_for_team(foot_team)
Player.find(4).reject_team_invitation_from(foot_team)



# создаем 10 футбольных команд

10.times do
  logo = File.open(Rails.root.join('misc','team_logos',"#{rand(1..9)}.jpg"))
  team = Team.create(name:Faker::Team.name, type_id:1, host_id: rand(1..10), logo: logo, address: Faker::Team.state)
  3.times do
    team.add_color color_palette[rand(0...color_palette.length)]
  end
end


# создаем 10 командных игр

10.times do 
  name = "Team Game \##{rand 100}"
  player_id = 1
  game_date_time = (Date.today-1.month) + rand(60).day
  playground_id = Random.rand(1..100)
  type_id = 1
  first_team_id = 1
  game = TeamGame.new(name: name, player_id: player_id, individual: false, game_date_time: game_date_time, playground_id: playground_id, type_id: type_id, first_team_id: first_team_id)
  game.save
  team = Team.find_by_id(rand(2..Team.count))
  game.invite_team team
  game.approve_team team
end
