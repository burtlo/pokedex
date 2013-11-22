class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons
  # GET /pokemons.json
  def index
    @pokemons = Pokemon.all

    respond_to do |format|
      format.html
      format.json { render json: @pokemons }
    end
  end

  # GET /pokemons/1
  # GET /pokemons/1.json
  def show
  end

  def search
    query = params[:query].gsub(/[^a-zA-Z0-9]*/,'')
    @pokemons = Pokemon.where("LOWER(name) LIKE LOWER(?)","%#{query}%").order(:name)

    respond_to do |format|
      format.json do
        render json: @pokemons
      end
    end
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
end
