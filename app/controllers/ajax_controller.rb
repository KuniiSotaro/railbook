class AjaxController < ApplicationController
    def upanel
        @time = Time.now.to_s
        render 'index'
    end

    def search
        # 選択ボックスに表示する出版社名を取得
        @books = Book.select(:publish).distinct
    end

    def result
        # 選択ボックスで指定された出版社でbooksテーブルを検索
        @books = book.where(publish: params[:publish])
    end
end
