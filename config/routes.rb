Rails.application.routes.draw do
  #get 'users/signup'

  #get 'issues/show'

  #get 'pages/welcome'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#welcome'
  get '/about' => 'pages#about'
  get 'signup' => 'users#signup', as: 'signup'
  get 'login' => 'users#login', as: 'login'
  post 'create_login_session' => 'users#create_login_session'
  delete 'logout' => 'users#logout', as: 'logout'



  #resources :users, only: [:create]  #equal to  users POST   /users(.:format)                     users#create
  post '/users' => 'users#create'

  # resources： issues－－－ 就可以代表下面的七条语句
  get 'issues/new' => 'issues#new'    # 这一行要写在 /issues/:id  那一行路由的前面
  # 之前报错： undefined method 'issues_path',所以要添加下面一行
  get 'issues' => 'issues#index', as: 'issues' #####
  post 'issues' => 'issues#create'

  get 'issues/:id' => "issues#show", as: 'issue' ##### this need helper route method
  delete 'issues/:id' => "issues#destroy"
  get 'issues/:id/edit' => 'issues#edit', as: 'edit_issue'  #######
  patch 'issues/:id' => 'issues#update'

  #comments  
  # 将issue_id 作为参数传递给controller
  # <%= form_tag("/issues/#{issue.id}/comments", method: :post) do  %>
  #post 'issues/:issue_id/comments' => 'comments#create'
  # undefined method `comments_path' 
  resources :comments, only: [:create]   # == post '/comments' => 'comments#create'

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
