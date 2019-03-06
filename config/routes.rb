Rails.application.routes.draw do
  namespace :api do

    get '/users' => 'users#index'
    post '/users' => 'users#create'



    post '/sessions' => 'sessions#create'


  end
end
