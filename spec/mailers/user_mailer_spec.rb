require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "you_won" do
    let(:guess) { create(:guess, is_successful: true) }
    let(:mail) { UserMailer.with(guess: guess).you_won }

    it "renders the headers" do
      expect(mail.subject).to eq("You won!")
      expect(mail.to).to eq([guess.user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Congratulations, you won!")
    end
  end
end
