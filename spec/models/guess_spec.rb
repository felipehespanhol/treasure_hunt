require 'rails_helper'

RSpec.describe Guess, type: :model do
  it { is_expected.to validate_presence_of(:coord_x) }
  it { is_expected.to validate_numericality_of(:coord_x) }
  it { is_expected.to validate_presence_of(:coord_y) }
  it { is_expected.to validate_numericality_of(:coord_y) }
  it { is_expected.to validate_numericality_of(:distance) }

  it { is_expected.to belong_to(:match) }
  it { is_expected.to belong_to(:user) }

  describe '.new_with_coordenates' do
    let(:coord_x) { 5 }
    let(:coord_y) { 4 }
    let(:match) { build(:match, treasure_x: 1, treasure_y: 1) }

    subject { Guess.new_with_coordenates(coord_x:, coord_y:, match:) }

    it 'builds a new guess and set the distance' do
      expect(subject.distance).to eq(5.0)
    end

    context 'when the distance is below 1000 meters' do
      it 'marks the guess as successful' do
        expect(subject.is_successful).to be(true)
      end
    end

    context 'when the distance is above 1000 meters' do
      let(:coord_y) { 1002 }

      it 'marks the guess as unsuccessful' do
        expect(subject.is_successful).to be(false)
      end
    end
  end
end
