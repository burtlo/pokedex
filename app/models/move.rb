class Move < ActiveRecord::Base
  belongs_to :type

  has_many :pokemon_moves
  has_many :pokemon, through: :pokemon_moves
end
