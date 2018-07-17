class CtrlController < ApplicationController
    # before/afterフィルターの登録
    # before_action :start_logger, only: [:index, :index2]
    # after_action :end_logger, except: :index

    # aroundフィルターの登録
    # around_action :around_logger

    # indexアクションに対してbeforeフィルターauthを登録
    before_action :auth, only: :index

    def para
        render plain: 'idパラメーター：' + params[:id]
    end

    def para_array
        render plain: 'categoryパラメーター：' + params[:category].inspect
    end

    def req_head
        render plain: request.headers['User-Agent']
    end

    def req_head2
        @headers = request.headers
    end

    def upload_process
        file = params[:upfile]
        name = file.original_filename
        perms = ['.jpg', '.jpeg', '.gif', '.png']
        if !perms.include?(File.extname(name).downcase)
            result = 'アップロードできるのは画像ファイルのみです。'
        elsif file.size > 1.megabyte
            result = 'ファイルサイズは1 MBまでです。'
        else
            File.open("public/docs/#{name}", 'wb') {|f| f.write(file.read)}
            result = "#{name}をアップロードしました。"
        end
        render plain: result
    end

    # アップロードフォームを表示するためのupdbアクション
    # (「〜/ctrl/updb/108」のようなアドレスで呼び出し可能)
    def updb
        @author = Author.find(1)
    end

    # 「アップロード」ボタンクリック時に呼び出され、アップロード処理を実施
    def updb_process
        @author = Author.find(params[:id])
        # アップロードファイルをデータベースに保存(失敗時は1番目のエラーのみを表示)
        if @author.update(params.require(:author).permit(:data))
            render plain: '保存に成功しました。'
        else
            render plain: @author.errors.full_messages[0]
        end
    end

    def html_plain
        render html: '<div style="color: Red;">今日はいい天気ですね。</div>'.html_safe
        # render inline: 'リクエスト情報：<%= debug request.haders %>'
    end

    def log
        logger.unknown('unknown')
        logger.fatal('fatal')
        logger.error('error')
        logger.warn('warn')
        logger.info('info')
        logger.debug('debug')
        render plain: 'ログはコンソール、またはログファイルから確認してください。'
    end

    def get_xml
        @books = Book.all
        render xml: @books
    end

    def get_json
        @books = Book.all
        render json: @books
    end

    def download
        @books = Book.all
    end

    def cookie
        # テンプレート変数@emailにクッキー値をセット
        @email = cookies[:email]
    end

    def cookie_rec
        # クッキー:emailをセット(有効期限は3ヶ月後)
        cookies[:email] = { value: params[:email],
            expires: 3.months.from_now, http_only: true }
        render plain: 'クッキーを保存しました。'
    end

    def session_show
        @email = session[:email]
    end

    def session_rec
        session[:email] = params[:email]
        render plain: 'セッションを保存しました。'
    end

    # フィルターの動作を確認するためのindexアクションを定義
    def index
        sleep 3
        render plain: 'indexアクションが実行されました。'
    end

    private
        # 開始時刻をログに記録
        # def start_logger
        #     logger.debug('[Start]' + Time.now.to_s)
        # end

        # 終了時刻をログに記録
        # def end_logger
        #     logger.debug('[Finish]' + Time.now.to_s)
        # end

        # 開始/終了時刻をログに記録
        # def around_logger
        #     logger.debug('[Start]' + Time.now.to_s)
        #     yield #アクションを実行
        #     logger.debug('[Finish]' + Time.now.to_s)
        # end

        def auth
            # 認証に利用するユーザ名/パスワード
            name = 'yyamada'
            passwd = '8cb2237d0679ca88db6464eac60da96345513964'
            # 基本認証を実行(入力されたユーザー名/パスワードをname/passwdと比較)
            authenticate_or_request_with_http_basic('Railsbook') do |n, p|
                n == name && Digest::SHA1.hexdigest(p) == passwd
            end
        end
end
