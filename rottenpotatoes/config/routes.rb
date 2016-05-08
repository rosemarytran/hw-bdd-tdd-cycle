Rottenpotatoes::Application.routes.draw do
  match 'movies/same_director/:id' => 'movies#same_director', :as => :same_director, via: [:get, :post]
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
