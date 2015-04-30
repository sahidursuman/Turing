Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'
  
  resources :computers
  resources :staffs, except: [:new]
  resources :types, only: [:new, :create, :show, :destroy]
  resources :wipes, only: [:new, :create, :show]
  
  # Rename new_staff route to register
  get '/register', to: 'staffs#new'
  
  # Login and Logout of sessions
  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'
  
  # Route for computer table
  get 'computertable', to: 'computers#table'
end

  #  The following routes are the manual equivalent of resources:
  #  get '/computers', to: 'computers#index'
  #  get 'computers/new', to: 'computers#new', as: 'new_computer'
  #  post '/computers', to: 'computers#create'
  #  get '/computers/:id/edit', to: 'computers#edit', as: 'edit_computer'
  #  patch '/computers/:id', to: 'computers#update'
  #  get 'computers/:id', to: 'computers#show', as: 'computer'
  #  delete 'computers/:id', to: 'computers#destroy'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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