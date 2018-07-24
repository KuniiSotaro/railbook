class ExtraController < ApplicationController
    def sendmail
        user = User.find(6)
        @mail = NoticeMailer.sendmail_confirm(user).deliver_now
        render plain: 'メールが正しく送信できました。'
    end
end
