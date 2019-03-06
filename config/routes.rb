Rails.application.routes.draw do
  namespace :api do

    get '/users' => 'users#index'
    post '/users' => 'users#create'
    get '/users/:id' => 'users#show'
    patch '/users/:id' => 'users#update'
    delete '/users/:id' => 'users#destroy'

    post '/sessions' => 'sessions#create'

    get '/animals' => 'animals#index'
    post '/animals' => 'animals#create'
    get '/animals/:id' => 'animals#show'
    patch '/animals/:id' => 'animals#update'
    delete '/animals/:id' => 'animals#destroy'

    get '/submissions' => 'submissions#index'
    post '/submissions' => 'submissions#create'
    get '/submissions/:id' => 'submissions#show'
    patch '/submissions/:id' => 'submissions#update'
    delete '/submissions/:id' => 'submissions#destroy'




  end
end
