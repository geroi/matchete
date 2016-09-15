class Friendship < ActiveRecord::Base
  belongs_to :friend
  belongs_to :player
end