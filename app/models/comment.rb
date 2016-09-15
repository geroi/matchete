class Comment < ActiveRecord::Base
  belongs_to :messagable, polymorphic: true
  belongs_to :author, class_name: 'Player', foreign_key: :author_id
end