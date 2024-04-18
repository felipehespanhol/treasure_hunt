require 'rails_helper'

RSpec.describe Guess, type: :model do
  it { is_expected.to validate_presence_of(:coord_x) }
  it { is_expected.to validate_numericality_of(:coord_x) }
  it { is_expected.to validate_presence_of(:coord_y) }
  it { is_expected.to validate_numericality_of(:coord_y) }
  it { is_expected.to validate_numericality_of(:distance) }

  it { is_expected.to belong_to(:match) }
  it { is_expected.to belong_to(:user) }

  describe '#calculate_distance' do
    let(:match) { create(:match, treasure_x: 1, treasure_y: 1) }
    let(:guess) { build(:guess, match: match, coord_x: 2, coord_y: 2) }

    it 'calculates the distance' do
      guess.save

      expect(guess.distance).to eq(1.41)
    end
  end

  describe '#calculate_success' do
    let(:match) { create(:match) }
    let(:guess) { build(:guess, match: match, coord_x: coord_x, coord_y: coord_y) }

    context 'when distance is less than or equal to 1000' do
      let(:coord_x) { match.treasure_x }
      let(:coord_y) { match.treasure_y + 1000 }

      it 'marks the guess as successful' do
        guess.save

        expect(guess.is_successful).to be(true)
      end
    end

    context 'when distance is greater than 1000' do
      let(:coord_x) { match.treasure_x }
      let(:coord_y) { match.treasure_y + 1001 }

      it 'marks the guess as unsuccessful' do
        guess.save

        expect(guess.is_successful).to be(false)
      end
    end
  end
end
