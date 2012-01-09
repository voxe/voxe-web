Joinplato::Application.routes.draw do
  
  # admin

  namespace :admin do
    match '/' => 'dashboard#index'
    resources :users
    resources :elections
    resources :candidates
    resources :tags
    resources :propositions do
      collection do
        get :manage
      end
    end
  end
  
  # API

  namespace :api, format: :json do
    namespace :v1 do

      resources :elections, except: :index do
        member do
          post :addtag
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
      
      resources :tags do
        collection do
          get :search
        end
      end
      
      resources :propositions do
        collection do
          get :search
        end
      end

      resources :candidacies

      resources :users do
        collection do
          get :search
        end
      end

    end
  end
  
  # webviews
  resources :webviews, :only => :index do
    collection do
      get :compare
      get :proposition
    end
  end
  
  # web-app
  
  namespace :plugins do
    resources :compare, :only => :index
  end
  
  # api doc
  
  match 'platform' => 'platform#index'
  
  namespace :platform do
    resources :endpoints do
      collection do
        get :elections
        get :candidates
        get :propositions
        get :tags
        get :candidacies
      end
    end
    resources :models do
      collection do
        get :election
        get :candidate
        get :proposition
        get :tag
        get :candidacy
        get :organization
      end
    end
    resources :plugins, :only => :index do
      collection do
        get :button
        get :bookmarklet
      end
    end
    resources :mobile, :only => :index
  end

  devise_for :users
  
  # mobile
  match ':election_namespace/tags' => 'elections#tags', :as => :election_tags
  match ':election_namespace/compare' => 'elections#compare', :as => :election_compare
  
  match ':election_namespace/:candidates/propositions/:id' => 'propositions#show', :as => :proposition
  match ':election_namespace/:candidates/:tag_namespace' => 'elections#compare'
  match ':election_namespace/:candidates' => 'elections#tags'
  
  match ':election_namespace' => 'elections#show', :as => :election
  
  root to: 'elections#index'

end