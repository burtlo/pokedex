Pokedex::Application.routes.draw do

  post "/pokemons/search", to: "pokemons#search"

  resources :pokemons, only: [ :index, :show ]

  root to: "pokemons#index"

end
