# Preview all emails at http://localhost:3000/rails/mailers/user
class UserMailerPreview < ActionMailer::Preview
  def you_won
    guess = Guess.where(is_successful: true).last

    UserMailer.with(guess: guess).you_won.deliver_now
  end
end
