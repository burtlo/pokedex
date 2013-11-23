class PokemonSerializer < ActiveModel::Serializer
  cached

  def cache_key
    [object, scope]
  end

  attributes :name, :index, :types, :image, :url,
    :effectiveAttacks, :ineffectiveAttacks,
    :evolutions, :firstEvolution, :otherEvolutions

  def types
    object.types.map { |t| t.name }.join(",")
  end

  def image
    image_path(object.image_name)
  end

  def url
    pokemon_url(object)
  end

  def effectiveAttacks
    object.effective_types_against.map do |atk|
      { name: atk.name, multiplier: atk.multiplier }
    end
  end

  def ineffectiveAttacks
    object.ineffective_types_against.map do |atk|
      { name: atk.name, multiplier: atk.multiplier }
    end
  end

  def evolutions
    object.pokemon_evolutions.map do |evolution|
      pokemon = evolution.evolves_to

      {
        event: evolution.event.to_s.titleize,
        index: pokemon.index,
        name: pokemon.name,
        url: pokemon_url(pokemon),
        image: image_path(pokemon.image_name)
      }
    end
  end

  def firstEvolution
    evolutions.first
  end

  def otherEvolutions
    evolutions[1..-1]
  end

  def image_path(image_name)
    ActionController::Base.helpers.image_path(image_name)
  end

end
