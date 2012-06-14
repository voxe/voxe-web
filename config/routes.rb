Joinplato::Application.routes.draw do
  
  # redirect www to .
  match "/" => redirect {|params| "http://voxe.org" }, :constraints => {:subdomain => "www"}
  match "/*path" => redirect {|params| "http://voxe.org/#{params[:path]}" }, :constraints => {:subdomain => "www"}
  
  # 2008
  match "/election-municipales" => redirect {|params| "http://france-municipales-2008.voxe.org/election-municipales" }
  match "/election-municipales/" => redirect {|params| "http://france-municipales-2008.voxe.org/election-municipales" }
  match "/election-municipales/*path" => redirect {|params| "http://france-municipales-2008.voxe.org/election-municipales/#{params[:path]}" }
  
  # sitemap
  match 'sitemap.xml' => 'web/sitemap#index', format: 'xml'
  
  # admin

  namespace :admin do
    match '/' => 'dashboard#index'
  end
  
  # API

  namespace :api, format: :json do
    namespace :v1 do

      resources :elections, except: :index do
        member do
          post :addtag
          delete :removetag
          post :addcandidacy
          post :movetags
          post :addcontributor
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
        collection do
          get :search
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
        member do
          get :comments
          post :addcomment
          post :addembed
          delete :removeembed
          delete :removecomment
        end
      end

      resources :candidacies do
        member do
          post :addorganization
        end
      end

      resources :users do
        collection do
          get :search
          get :verify
          get :self
          get :facebookconnect
          get :admins
        end
        member do
          put :addadmin
          put :removeadmin
        end
      end

      resources :organizations
      
      resources :comparisons do
        collection do
          get :search
        end
      end

    end
  end
  
  # webviews
  namespace :webviews, format: "touch" do
    resources :comparisons, only: :index
    resources :propositions, only: :show
  end
  
  # web-app
  namespace :embed do
    resources :elections, only: :show
    resources :live, only: :index
    resources :partners, only: :index do
      collection do
        get :huffingtonpost
      end
    end
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
        get :users
        get :organizations
      end
    end
    resources :models do
      collection do
        get :election
        get :candidate
        get :proposition
        get :tag
        get :candidacy
        get :user
        get :organization
      end
    end
    resources :embed, :only => :index do
      collection do
        get :button
        get :bookmarklet
      end
    end
    resources :mobile, :only => :index
  end

  devise_for :users
  
  # all platforms
  match 'about/' => 'Web::Static#about', :as => :about
  match 'about/how' => 'Web::Static#how', :as => :how
  match 'about/team' => 'Web::Static#team', :as => :team
  match 'about/press' => 'Web::Static#press', :as => :press
  match 'about/thanks' => 'Web::Static#thanks', :as => :thanks
  match 'apps' => 'Web::Static#apps', :as => :apps
  
  # touch
  scope :module => "touch", format: "touch", constraints: TouchConstraint.new do
    match ':namespace/:candidacies/:tag' => 'comparisons#show', :as => :compare
    match ':namespace/:candidacies' => 'tags#index', :as => :tags
    match ':namespace' => 'elections#show', :as => :election
    
    root to: 'elections#index'
  end
  
  # mobile
  scope :module => "mobile", format: "mobile", constraints: MobileConstraint.new do
    match ':namespace/:candidacies/:tag' => 'elections#compare', :as => :compare
    
    match 'propositions/:id' => 'propositions#show', :as => :proposition
    
    match ':namespace/candidacies' => 'candidacies#create', :as => :candidacies
    match ':namespace/:candidacies' => 'tags#index', :as => :tags
    match ':namespace' => 'elections#show', :as => :election
    
    root to: 'elections#index'
  end
  
  # web
  scope :module => "web", format: "html" do
    match 'propositions/:id' => 'propositions#show', :as => :proposition
    
    match ':namespace/:candidacies/:tag' => 'comparisons#show', :as => :compare
    match ':namespace/:candidacies' => 'tags#index', :as => :tags
    match ':namespace' => 'elections#show', :as => :election
    
    root to: 'application#index'
  end
  
end