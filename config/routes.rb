Rails.application.routes.draw do

  devise_for :users
  root :to => "rtmms#index"
  post "rtmm/get_data", :to => "rtmms#get_data"
  post "rtmm/del_data", :to => "rtmms#del_data"
  get "rtmm/get_msg", :to =>"rtmms#get_msg"
  get "rtmm/data_cht", :to => "rtmms#data_cht"
  get "rtmm/data_apple", :to => "rtmms#data_apple"
  get "rtmm/data_list", :to => "rtmms#data_list"
  resources :rtmms
  namespace :rtmm do
    resources :customer_base
    resources :history
    resources :supplier
    resources :messages
    resources :conditionals
  end

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
end
