class Guess < ApplicationRecord
  belongs_to :match
  belongs_to :user

  validates :coord_x, :coord_y, numericality: true, presence: true
  validates :distance, numericality: true
end
