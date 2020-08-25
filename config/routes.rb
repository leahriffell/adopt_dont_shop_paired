Rails.application.routes.draw do
  get '/', to: 'welcome#index'

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

  get '/shelters/:id/add_review', to: 'reviews#new'
  post '/shelters/:id', to: 'reviews#create'
  get '/shelters/:id/edit_review/:id', to: 'reviews#edit'
  patch '/shelters/:id/reviews/:id', to: 'reviews#update'
  delete '/shelters/:id/reviews/:id', to: 'reviews#destroy'
end
