class User < ApplicationRecord
  validates :email, presence: true

  has_many :guesses
end
