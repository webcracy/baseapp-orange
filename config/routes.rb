# See how all your routes lay out with "rake routes"
ActionController::Routing::Routes.draw do |map|
  
  # RESTful rewrites
  
  map.signup   '/signup',   :controller => 'users',    :action => 'new'
  map.register '/register', :controller => 'users',    :action => 'create'
  map.activate '/activate/:activation_code', :controller => 'users',    :action => 'activate'
  map.login    '/login',    :controller => 'sessions', :action => 'new'
  map.logout   '/logout',   :controller => 'sessions', :action => 'destroy', :conditions => {:method => :delete}
  
  map.user_troubleshooting '/users/troubleshooting', :controller => 'users', :action => 'troubleshooting'
  map.user_forgot_password '/users/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.user_reset_password  '/users/reset_password/:password_reset_code', :controller => 'users', :action => 'reset_password'
  map.user_forgot_login    '/users/forgot_login',    :controller => 'users', :action => 'forgot_login'
  map.user_clueless        '/users/clueless',        :controller => 'users', :action => 'clueless'
  
  map.open_id_complete '/opensession', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.open_id_create '/opencreate', :controller => "users", :action => "create", :requirements => { :method => :get }

  map.pages '/pages/:permalink', :controller=>"pages", :action=>"show" 
  map.news '/news/:permalink', :controller=>"news", :action=>"show" 
  map.news_archive '/news-archive', :controller=>"news", :action=>"index" 
    
  map.resources :users, :member => { :edit_password => :get,
                                     :update_password => :put,
                                     :edit_email => :get,
                                     :update_email => :put,
                                     :edit_avatar => :get, 
                                     :update_avatar => :put }
                                     
                             
  map.resource :session
  map.resources :profiles
  
  # Administration
  map.namespace(:admin) do |admin|
    admin.root :controller => 'dashboard', :action => 'index'
    admin.resources :settings
    admin.resources :contents
    admin.resources :pages, :collection => { :order => :get, :sort => :put }
    admin.resources :news, :singular => 'newsclip' 
    admin.resources :users, :member => { :suspend   => :put,
                                         :unsuspend => :put,
                                         :activate  => :put, 
                                         :purge     => :delete,
                                         :reset_password => :put },
                            :collection => { :pending   => :get,
                                             :active    => :get, 
                                             :suspended => :get, 
                                             :deleted   => :get }
  end
  
  # Dashboard as the default location
  map.root :controller => 'dashboard', :action => 'index' 

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
