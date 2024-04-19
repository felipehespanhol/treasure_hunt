class Guess < ApplicationRecord
  DISTANCE_FOR_SUCCESS = 1000

  belongs_to :match
  belongs_to :user

  validates :coord_x, :coord_y, numericality: true, presence: true
  validates :distance, numericality: true

  def self.new_with_coordenates(attributes)
    Guess.new(attributes).tap do |guess|
      guess.distance = guess.calculate_distance

      guess.is_successful = guess.calculate_success
    end
  end

  def calculate_distance
    return unless match && coord_x && coord_y

    Math.sqrt(
      (coord_x - match.treasure_x)**2 + (coord_y - match.treasure_y)**2
    ).round(2)
  end

  def calculate_success
    return unless distance

    distance <= DISTANCE_FOR_SUCCESS
  end
end
