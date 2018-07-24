class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  # def sendmail_confirm
  #   @greeting = "Hi"
  #
  #   mail to: "to@example.org"
  # end

  default from: 'webmaster@wings.msn.to',
            cc: 'CQW15204@nifty.com'

  def sendmail_confirm(user)
      @user = user
      # attachments['wings.jpg'] = File.read(Rails.root.join('tmp/data/wings.jpg'))
      mail to: user.email,
            subject: 'ユーザー登録ありがとうございました'
  end
end
