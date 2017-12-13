Rails.application.routes.draw do
  get 'song_archives/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, :queries, :text_inputs, :song_archives, :song_results

end
