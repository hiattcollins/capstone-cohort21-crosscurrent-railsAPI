Rails.application.routes.draw do
  # get 'song_archives/index'

  post 'text_query', to: 'queries#text_query', as: 'text_query'

  post 'query_to_archive', to: 'song_archives#query_to_archive', as: 'query_to_archive'

  get 'multi_insert', to: 'song_results#multi_insert', as: 'multi_insert'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, :queries, :text_inputs, :song_archives, :song_results

end
