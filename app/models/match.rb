class Match < ApplicationRecord
  MAX_COORD = 10_000

  validates :treasure_x, :treasure_y, numericality: { in: 0..MAX_COORD }, presence: true
  validates :closest_distance, numericality: true, allow_nil: true

  belongs_to :winner, class_name: 'User', optional: true, foreign_key: 'winner_id'
  has_many :guesses, dependent: :destroy

  def self.find_current_or_create_next
    Match.where(winner: nil).last || Match.create(
      treasure_x: Random.rand(MAX_COORD),
      treasure_y: Random.rand(MAX_COORD)
    )
  end
end
