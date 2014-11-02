Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  post 'apis/markdown_preview'
  post 'apis/file_receiver'
  get 'apis/user_mention'

  get 'tags/:name/events' => 'tags#events', as: 'event_tag'

  root 'welcome#top', as: 'root'

  get 'stock' => 'stock#show', as: 'stock'
  get 'flow'  => 'flow#show',  as: 'flow'
  get 'search'  => 'search#show',  as: 'search'
  get 'templates'  => 'templates#show',  as: 'templates'
  get 'watchings' => 'watchings#show', as: 'watching'

  get 'posts/:id/fork' => 'posts#fork', as: 'fork_post'
  post 'posts/:id/mail' => 'posts#mail', as: 'mail_post'
  post 'posts/:id/comment' => 'posts#comment', as: 'comment_post'
  get 'posts/:id/slideshow' => 'posts#slideshow', as: 'slideshow_post'
  get 'posts/:id/watch' => 'posts#watch', as: 'watch_post'
  resources :posts, except: [:index]

  get 'notification_bridge/:id'  => 'notifications#bridge',  as: 'notification_bridge'

  post 'tags/:name/merge_to/:merge_to_name' => 'tags#merge_to', as: 'merge_to_tag'
  post 'tags/:name/move_to/:move_to_name' => 'tags#move_to', as: 'move_to_tag'
  resources :tags, param: :name, except: [:index]

  devise_for :users,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks',
               registrations: 'users/registrations'
             },
             skip: [
               :passwords,
               :registrations
             ]

  resource :user
end
