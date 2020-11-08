Rails.application.routes.draw do
  get '/users/:id/like' => 'users#like'
  post '/like/:id/destroy' => 'like#destroy'
  post '/like/:id/create' => 'like#create'
  get '/posts/test' => 'posts#test'
  get '/posts/index'
  get '/posts/new' => 'posts#new'
  post '/posts/create' => 'posts#create'
  get '/' => 'home#top'
  get '/about' => 'home#about'
  get '/posts/:id/edit' => 'posts#edit'
  post '/posts/:id/update' => 'posts#update'
  post '/posts/:id/destroy' => 'posts#destroy'
  get '/posts/:id' => 'posts#show'

  get '/users/index' => 'users#index'
  get '/signup' => 'users#new'
  post '/users/create' => 'users#create'
  get '/users/:id/edit' => 'users#edit'
  post '/users/:id/update' => 'users#update'
  get '/users/:id' => 'users#show'
  post '/users/:id/destroy' => 'users#destroy'

  get '/login' => 'users#login_form'
  post '/login' => 'users#login'
  
  post '/logout' => 'users#logout'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
