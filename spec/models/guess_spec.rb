require 'rails_helper'

RSpec.describe Guess, type: :model do
  it { is_expected.to validate_presence_of(:coord_x) }
  it { is_expected.to validate_numericality_of(:coord_x) }
  it { is_expected.to validate_presence_of(:coord_y) }
  it { is_expected.to validate_numericality_of(:coord_y) }
  it { is_expected.to validate_numericality_of(:distance) }
end
