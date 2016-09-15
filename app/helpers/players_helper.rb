module PlayersHelper
	def player_avatar player, size_symbol, opts={}
		raw "<img src='#{player.avatar.url(size_symbol)}' class='img-circle' width='#{opts[:width]}' height='#{opts[:height]}'>"
	end
end
