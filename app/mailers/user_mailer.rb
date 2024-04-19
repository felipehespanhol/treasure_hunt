class UserMailer < ApplicationMailer
  def you_won
    @guess = params[:guess]
    @match = @guess.match
    @user = @guess.user

    mail(to: @user.email, subject: "You won!")
  end
end
