class Friendship < ActiveRecord::Base
  belongs_to :player
  belongs_to :friend, :class_name => "Player", :foreign_key => "friend_id"
end