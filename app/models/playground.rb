class Playground < ActiveRecord::Base
	def photo_url
		"http://op.mos.ru/MEDIA/showFile?id=#{self.photo}"
	end
end
