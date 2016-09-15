ActiveAdmin.register Game do
  permit_params :name,:player_id,:type_id,:playground_id,:first_team_id,:second_team_id,:first_team_score,:second_team_score,:game_date_time,:created_at,:updated_at
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
