# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( search/search.js profile/friend_search.js )
Rails.application.config.assets.precompile += %w( profile/friend_invitations.js games/edit.js teams/search.js teams/show.js teams/color_picker.js)
Rails.application.config.assets.precompile += %w( search/date_picker.js games/new.js games/timepicker.js games/show.js games/date_time_picker.js )
Rails.application.config.assets.precompile += %w( games/select_picker_locale.js common/map_picker.js common/playground_card.js common/share.js)
Rails.application.config.assets.precompile += %w( games/index.js inspinia.js  search/date_range_picker.js profile/crop.js games/map_to_show.js blueimp/jquery.blueimp-gallery.min.js)