class SorceryMailer < ActionMailer::Base
  default from: "marcaexpressa@gmail.com"

  def activation_needed_email(user)
    @user = user
    @url = activate_user_url(user.activation_token)
    mail(:to => user.email, :subject => I18n.t('user.mailer.title.activation_needed'))
  end

  def activation_success_email(user)
    @user = user
    @url  = login_url
    mail(:to => user.email, :subject => I18n.t('user.mailer.title.activation_success'))
  end

  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)
    mail(:to => user.email, :subject => I18n.t('user.mailer.title.reset_password'))
  end
end
