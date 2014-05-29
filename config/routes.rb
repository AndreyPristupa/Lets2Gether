Rails.application.routes.draw do
  namespace :users do
  get 'omniauth_callbacks/facebook'
  end

  namespace :users do
  get 'omniauth_callbacks/vkontakte'
  end

  resources :payments do
    collection do
      post 'callback'
      post 'success'
      get 'paymentslist'
      get 'privat24'
    end
  end

  resources :categories
  resources :articles

  devise_for :users, controllers: { registrations: 'registrations', :omniauth_callbacks => 'users/omniauth_callbacks' }
  resources :projects do
    collection do
      get 'search'
    end
  end
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :users
  resources :commons
  resources :stories
  concern   :user_comments,  TheComments::UserRoutes.new
  concern   :admin_comments, TheComments::AdminRoutes.new
  resources :comments, concerns:  [:user_comments, :admin_comments]
  #scope "(:locale)", locale: /en|ru/ do
  #  resources :commons
  #  resources :users
  #  resources :projects
  #  resources :stories
  #end

  get 'about_us', to:'articles#about_us', as: :about_us
  get 'profile', to: 'profiles#index', as: :root_user
  match 'profile/update', to: 'profiles#update', as: :update_profile,via: [:get, :put]

  #resource :profiles do
  #  collection do
  #    post 'profile', to: 'profiles#profile',as: :update_userprofile
  #  end
  #end

  #get 'profile/update' => 'profiles#update'
  #get 'profile/index', as: 'profile'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
     get '/:locale' => 'commons#index'
     root 'commons#index'

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
