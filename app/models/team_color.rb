class TeamColor < ActiveRecord::Base
  self.table_name = 'team_colors'
  belongs_to :team
end