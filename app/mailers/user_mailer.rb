class UserMailer < ApplicationMailer

default from: 'notifications@matchete.ru'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://www.matchete.ru'
    mail(to: @user.email, subject: 'Добро пожаловать на Matchete!')
  end

end
