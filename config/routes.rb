class MobileConstraint
  
  def matches? request
    wap_device?(request) || search_bot?(request) || facebook_bot?(request) || ie_6?(request)
  end
  
  def wap_device? request
    request.user_agent.to_s.downcase =~ /blackberry|nokia|ericsson|webos/
  end
  
  def search_bot? request
    user_agent = request.user_agent.downcase
    [ 'msnbot', 'yahoo! slurp','googlebot'].detect { |bot| user_agent.include? bot }
  end
  
  def facebook_bot? request
    request.user_agent.to_s.downcase =~ /facebookexternalhit/
  end
  
  def ie_6? request
    request.user_agent.to_s.downcase =~ /msie 6/
  end
  
end

class TouchConstraint
  
  def matches? request
    touch_device?(request) || touch_subdomain?(request)
  end
  
  def touch_device? request
    request.user_agent.to_s.downcase =~ /iphone|android/
  end
  
  def touch_subdomain? request
    request.subdomain.present? && request.subdomain == "touch"
  end
  
end

Joinplato::Application.routes.draw do
  
  # redirect www to .
  match "/" => redirect {|params| "http://voxe.org" }, :constraints => {:subdomain => "www"}
  match "/*path" => redirect {|params| "http://voxe.org/#{params[:path]}" }, :constraints => {:subdomain => "www"}
  
  # sitemap
  match 'sitemap.xml' => 'web/sitemap#index', format: 'xml'
  
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
          delete :removetag
          post :addcandidacy
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
          post :addcomment
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
        end
      end

      resources :organizations

    end
  end
  
  # webviews
  namespace :webviews, format: "touch" do
    resources :comparisons, only: :index
    resources :propositions, only: :show
  end
  # resources :webviews, :only => :index do
  #   collection do
  #     get :compare
  #     get :proposition
  #   end
  # end
  
  # web-app
  namespace :embed do
    resources :elections, only: :show
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
    
    match ':namespace/:candidacy/propositions/:id' => 'propositions#show', :as => :proposition
    
    match ':namespace/candidacies' => 'candidacies#create', :as => :candidacies
    match ':namespace/:candidacies' => 'tags#index', :as => :tags
    match ':namespace' => 'elections#show', :as => :election
    
    root to: 'elections#index'
  end
  
  # web
  scope :module => "web", format: "html" do
    match 'about/' => 'static#about', :as => :about
    match 'about/team' => 'static#team', :as => :team
    match 'about/press' => 'static#press', :as => :press
    match 'about/terms' => 'static#terms', :as => :terms
    match 'join' => 'static#join', :as => :join
    match 'apps' => 'static#apps', :as => :apps
    
    match ':namespace/:candidacies/:tag' => 'comparisons#show', :as => :compare
    match ':namespace/:candidacies' => 'tags#index', :as => :tags
    match ':namespace' => 'elections#show', :as => :election
    
    root to: 'application#index'
  end
  
end