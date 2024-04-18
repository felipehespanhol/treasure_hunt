require 'rails_helper'

RSpec.describe Match, type: :model do
  it { is_expected.to validate_presence_of(:treasure_x) }

  it { is_expected.to validate_presence_of(:treasure_y) }

  it { is_expected.to validate_numericality_of(:treasure_x).is_in(0..10_000) }

  it { is_expected.to validate_numericality_of(:treasure_y).is_in(0..10_000) }

  it { is_expected.to validate_numericality_of(:closest_distance) }

  it { is_expected.to have_many(:guesses) }

  it { is_expected.to belong_to(:winner).optional(true) }

  describe '.find_current_or_create_next' do
    let!(:match) { create(:match) }

    context 'when there is a match without a winner' do
      it 'returns the match' do
        expect(described_class.find_current_or_create_next).to eq(match)
      end
    end

    context 'when there is no match without a winner' do
      before { match.update!(winner: create(:user)) }

      it 'creates a new match' do
        allow(Random).to receive(:rand).and_return(9999)

        expect { described_class.find_current_or_create_next }.to change(described_class, :count).by(1)

        match = Match.last

        expect([match.treasure_x, match.treasure_y]).to eq([9999, 9999])
      end
    end
  end
end
