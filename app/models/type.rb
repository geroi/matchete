class Type < ActiveRecord::Base
  has_many :teams
  has_many :games

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>", small: "50x50>", tiny: "25x25>" }, default_url: "/images/:style/default_type_logo.gif"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
end
