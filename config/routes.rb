Rendezvous::Application.routes.draw do


  root 'home#top', as: 'root'

  post 'posts/preview' => 'posts#preview'
  # get 'posts/show_fragment' => 'posts#show_fragment'
  get 'posts/:id/fork' => 'posts#fork', as: 'fork_post'
  post 'posts/:id/mail' => 'posts#mail', as: 'mail_post'
  post 'posts/:id/comment' => 'posts#comment', as: 'comment_post'
  resources :posts

  get 'tags/:name' => 'tags#show', as: 'show_tag'
  post 'tags/:name/merge_to/:merge_to_name' => 'tags#merge_to', as: 'merge_to_tag'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
