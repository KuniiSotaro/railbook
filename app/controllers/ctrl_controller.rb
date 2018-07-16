class CtrlController < ApplicationController
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
end
