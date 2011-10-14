Joinplato::Application.routes.draw do

  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do

      resources :elections do
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
          get :elections
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
