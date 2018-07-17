class LoginController < ApplicationController
    # [ログイン]ボタンのクリック時に実行されるアクション
    def auth
        # 入力値に従ってユーザー情報を取得
        usr = User.find_by(username: params[:username])
        # ユーザー情報が存在し、認証(authenticate)に成功したら
        if usr && usr.authenticate(params[:password]).then
            # 成功した場合はid値をセッションに設定し、元々の要求ページにリダイレクト
            reset_session
            session[:usr] = usr.id
            redirect_to params[:referer]
        else
            # 失敗した場合はflash[:referer]を再セットし、ログインページを再描画
            flash.now[:referer] = params[:referer]
            @error = 'ユーザー名/パスワードが間違っています。'
            render 'index'
        end
    end
end
