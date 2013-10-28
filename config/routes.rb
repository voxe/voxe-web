Joinplato::Application.routes.draw do

  # redirect www to .
  match "/" => redirect("http://voxe.org"), :constraints => {:subdomain => "www"}
  match "/*path" => redirect {|params, request| "http://voxe.org/#{params[:path]}" }, :constraints => {:subdomain => "www"}

  # 2008
  match "/election-municipales" => redirect('/')
  match "/election-municipales/" => redirect('/')
  match "/election-municipales/*path" => redirect('/')

  # sitemap
  match 'sitemap.xml' => 'web/sitemap#index', format: 'xml'

  # admin
  namespace :admin do
    match '/' => 'dashboard#index'
  end

  # New admin (Let the old live until candidate BO isn't finished)
  namespace :new_admin do
    match '/' => 'elections#index'
    resources :countries
    resources :tags, only: [:create]
    resources :elections do
      resources :election_tags, only: [:index]
      resources :candidacies, only: [:index, :create, :destroy] do
        post :toggle
      end
      post 'publish'
      post 'unpublish'
      resources :tags, only: [:create]
    end
    resources :candidacy_candidate_profiles
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
          get :contributors
          post :addambassador
          get :ambassadors
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
        scope module: :user_actions do
          resource :favorite, only: [:create, :destroy]
          resource :support, only: [:create, :destroy]
          resource :against, only: [:create, :destroy]
        end
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
          put :self
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

      resources :countries do
        collection do
          get :search
        end
      end

      resources :cities do
        get :search, on: :collection
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
        get :countries
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
        get :country
      end
    end
    resources :embed, :only => :index do
      collection do
        get :button
        get :bookmarklet
      end
    end
    resources :mobile, :only => :index
    resources :open_data, :only => :index
  end

  devise_for :users

  # Back-office for candidates
  namespace :backoffice do
    root to: 'my_profiles#show'
    resources :candidacies
    resource :my_profile do
      member do
        get :thank_you
      end
    end
    resources :propositions
    match 'propositions/categorie/:namespace_categ' => 'propositions#index', :as => :propositions_categorie
  end

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
    match 'country-:countrynamespace' => 'countries#show', :as => :country
    match 'election/:electionnamespace/candidate/:candidatenamespace' => 'candidacy_candidate_profiles#show', as: :candidate_profile
    match 'citizen/:id' => 'citizen_profiles#show', as: :citizen_profiles
    match ':namespace/:candidacies/:tag' => 'comparisons#show', :as => :compare
    match ':namespace/:candidacies' => 'tags#index', :as => :tags
    match ':namespace' => 'elections#show', :as => :election

    root to: 'application#index'
  end

end
