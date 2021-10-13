Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
   match '/movies/similar/:id', to: 'movies#similar', as: 'similar_directors', via: :get
end