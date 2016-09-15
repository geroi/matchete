module CustomViewHelper
	def random_color
      letters = '0123456789ABCDEF'.split('');
      color = '#';
      6.times do 
          color += letters[rand(0...16)];
      end
      return color
	end
end