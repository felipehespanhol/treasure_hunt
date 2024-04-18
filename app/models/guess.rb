class Guess < ApplicationRecord
  DISTANCE_FOR_SUCCESS = 1000

  belongs_to :match
  belongs_to :user

  validates :coord_x, :coord_y, numericality: true, presence: true
  validates :distance, numericality: true

  before_validation :calculate_distance
  before_validation :calculate_success

  private

  def calculate_distance
    return unless match && coord_x && coord_y

    self.distance = Math.sqrt(
      (coord_x - match.treasure_x)**2 + (coord_y - match.treasure_y)**2
    ).round(2)
  end

  def calculate_success
    return unless distance

    self.is_successful = distance <= DISTANCE_FOR_SUCCESS
  end
end
