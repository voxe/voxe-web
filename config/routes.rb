Joinplato::Application.routes.draw do
  
  # web
  resources :elections do
    member do
      post :compare
    end
  end

  devise_for :users

  namespace :admin do
    resources :users
  end

  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do

      resources :elections, :except => :index do
        member do
          post :addtheme
          post :addcandidate
        end
        collection do
          get :search
        end
      end

      resources :themes do
        member do
          post :addphoto
        end
      end

      resources :candidates do
        member do
          post :addphoto
        end
      end

      resources :propositions do
        collection do
          get :search
        end
      end

    end
  end
  
  match 'ux/' => 'ux#index'

  root to: 'elections#index'

end