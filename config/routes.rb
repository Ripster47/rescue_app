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
    get '/submissions/requests' => 'submissions#index_pending'
    get '/submissions/:id' => 'submissions#show'
    patch '/submissions/:id' => 'submissions#update'
    delete '/submissions/:id' => 'submissions#destroy'

    get '/google/redirect', to: 'appointments#redirect', as: 'redirect'
    get '/google/callback', to: 'appointments#callback', as: 'callback'
    get '/google/calendars', to: 'appointments#calendars', as: 'calendars'
    get '/google/events/:calendar_id', to: 'appointments#events', as: 'events', calendar_id: /[^\/]+/
    post '/google/events/:calendar_id', to: 'appointments#new_event', as: 'new_event', calendar_id: /[^\/]+/

  end
end
