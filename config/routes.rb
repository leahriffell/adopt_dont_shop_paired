Rails.application.routes.draw do
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'

  # this route must come later or else app will think that any path after /shelters/ is an id and will try and use the show action when we don't want it to (ex: new)
  get '/shelters/:id', to: 'shelters#show'

  get '/shelters/:id/edit', to:'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters', to: 'shelters#destroy'
end
