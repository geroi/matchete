Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  ActiveAdmin.routes(self)

  # devise_for :users#, ActiveAdmin::Devise.config

  get 'players/profile', :as => :user_root
  get 'profile/games' => 'games#user_games', :as => :user_games
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root :to => 'games#index'
  get '/search' => 'game_search#main', :as => :find_game
  post '/search' => 'game_search#fetch_games'

  post '/game/new' => 'game#create', :as => :create_game
  get '/tournament' => 'tournament#show', :as => :find_tournament
  get '/tournament/new' => 'tournament#new', :as => :create_tournament
  get '/logout' => 'login#logout', :as => :log_out

  post '/players/search' => 'players#look_for_players', :as => :look_for_players
  post '/send_game_message' => 'players#send_game_message', as: :send_game_message
  
  post '/send_team_message' => 'players#send_team_message', as: :send_team_message

  resources :games, except: [:new, :edit] do
    member do
      delete '/delete' => 'games#destroy', as: :delete
      post '/messages' => 'games#get_messages', as: :messages
      post '/approve_participant/:player_id' => 'games#approve_participant', :as => :approve_participant
      post '/add_participant/:player_id' => 'games#add_participant', :as => :add_participant
      post '/become_participant/:player_id' => 'games#become_participant', :as => :participate_in
      post '/deny_participant/:player_id' => 'games#deny_participant', :as => :deny_participant
    end
  end

  resources :teams do
    member do
      post '/messages' => 'teams#get_team_messages', as: :team_messages
      get '/invitations' => 'teams#invitations', as: :invitations
      get '/claims' => 'teams#claims', as: :claims
      post '/approve_teammate_claim/:player_id' => 'teams#approve_teammate_claim', :as => :approve_teammate_claim
      post '/approve_team_invitation/:player_id' => 'teams#approve_team_invitation', :as => :approve_team_invitation
      post '/become_teammate/:player_id' => 'teams#become_teammate', :as => :become_teammate
      post '/invite_teammate/:player_id' => 'teams#invite_teammate', :as => :invite_teammate
      post '/delete_teammate/:player_id' => 'teams#delete_teammate', :as => :delete_teammate
    end
    
    collection do
      get '/search' => 'teams#search', as: :search
      post '/look_for_teams' => 'teams#look_for_teams', as: :look_for
      post '/search_players_for_team' => 'teams#search_players_for_team', as: :search_players_for
    end
  end

    get '/profile' => 'profile#index', as: :profile
    get '/profile/edit' => 'profile#edit', as: :profile_edit
    put '/profile' => 'profile#update', as: :profile_update

  namespace :profile do
        get '/invitations', action: 'invitations'
        get '/search', action: 'search'
        post '/search' => 'friends#look_for', :as => :look_for_friends
    resources :friends, only: [:index] do
      member do
        post 'approve'
        post 'invite'
        post 'reject'
        post 'delete'
      end
    end
  end  
  
  get '/team-game/new' => 'games#new_team_game', as:  :new_team_game
  post '/team-game/' => 'games#create_team_game', as:  :create_team_game
  get '/team-game/:id/edit' => 'games#edit_team_game', as:  :edit_team_game
  put '/team-game/:id' => 'games#update_team_game', as: :update_team_game
  # patch '/team-game/:id' => 'games#update_team_game', as: :update_team_game
  get '/individual-game/new' => 'games#new', as:  :new_game
  get '/individual-game/:id/edit' => 'games#edit', as:  :edit_game
  post '/games/:id/approve_team/:team_id' => 'games#approve_team', as: :approve_team
  post '/games/:id/reject_team/:team_id' => 'games#reject_team', as: :reject_team
  get '/get_playgrounds' => 'playground#fetch_playgrounds', as: :fetch_playgrounds

  get '/playgrounds/:id' => 'playground#show', as: :show_playground
  
  get '/test' => 'players#test'
  get '/:id' => "player#show", as: :player
  resources :tournaments
  

  post '/test-search' => 'players#test_search'

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end