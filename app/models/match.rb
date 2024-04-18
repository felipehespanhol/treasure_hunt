class Match < ApplicationRecord
  MAX_COORD = 10_000

  validates :treasure_x, :treasure_y, numericality: { in: 0..MAX_COORD }, presence: true
  validates :closest_distance, numericality: true
end
