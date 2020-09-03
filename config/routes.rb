Rails.application.routes.draw do
  root 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'

  get '/pets', to: 'pets#index'
  # this route must come later or else app will think that any path after /shelters/ is an id and will try and use the show action when we don't want it to (ex: new)
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to:'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/shelters/:id/pets', to:'shelter_pets#index'

  get '/pets/:id', to: 'pets#show'
  get '/shelters/:id/pets/new', to:'pets#new'
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id/edit', to:'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'
  patch '/cart/:id', to:'cart#update'

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/shelters/:id/reviews', to: 'reviews#create'
  get '/shelters/:id/reviews/:id/edit', to: 'reviews#edit'
  patch '/shelters/:id/reviews/:id', to: 'reviews#update'
  delete '/shelters/:id/reviews/:id', to: 'reviews#destroy'

  get '/favorites', to: 'favorites#index'
  delete '/favorites/all', to: 'cart#delete_all'
  delete '/favorites/:id', to: 'cart#delete'

  get 'applications/new', to: 'applications#new'
  post 'applications', to: 'applications#create'
  get 'applications/:id', to: 'applications#show'
  get '/pets/:id/applications', to: 'application_pets#index'
  patch '/pets/:id/application_status', to: 'pets#change_application_status'

  get '/users/sign_up', to: 'users#sign_up'
  post 'users', to: 'users#create'
  get '/profile', to: 'users#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
