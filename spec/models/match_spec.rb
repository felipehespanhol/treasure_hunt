require 'rails_helper'

RSpec.describe Match, type: :model do
  it { is_expected.to validate_presence_of(:treasure_x) }

  it { is_expected.to validate_presence_of(:treasure_y) }

  it { is_expected.to validate_numericality_of(:treasure_x).is_in(0..10_000) }

  it { is_expected.to validate_numericality_of(:treasure_y).is_in(0..10_000) }

  it { is_expected.to validate_numericality_of(:closest_distance) }
end
