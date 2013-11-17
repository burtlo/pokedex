class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons
  # GET /pokemons.json
  def index
    @pokemons = Pokemon.all
  end

  # GET /pokemons/1
  # GET /pokemons/1.json
  def show
  end

  def search
    @pokemons = Pokemon.where("name LIKE ?","%#{params[:query]}%")
    @pokemons = @pokemons.map {|p| hash_representation(p) }
    render json: { pokemon: @pokemons, query: params[:query] }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_params
      params.require(:pokemon).permit(:index, :name)
    end

    def hash_representation(p)
      { name: p.name,
        index: p.index,
        types: p.types.map { |t| t.name }.join(","),
        image: ActionController::Base.helpers.image_path(p.image_name),
        url: pokemon_url(p),
        effectiveAttacks: p.effective_types_against.map { |atk| { name: atk.name, color: Type.find_by_name(atk.name).color, multiplier: atk.multiplier } },
        ineffectiveAttacks: p.ineffective_types_against.map { |atk| { name: atk.name, color: Type.find_by_name(atk.name).color, multiplier: atk.multiplier } }
      }
    end
end
