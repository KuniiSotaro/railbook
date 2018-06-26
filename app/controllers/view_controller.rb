class ViewController < ApplicationController
    def keyword
    end

    def search
    end

    def form_tag
        @book = Book.new
    end

    def create
    end

    def form_for
        @book = Book.new
    end

    def field
        @book = Book.new
    end

    def html5
        @book = Book.new
    end

    def select
        @book = Book.new(publish: '技術評論社')
    end

    def col_select
        # フォームの元となるモデルを準備
        @book = Book.new(publish: '技術評論社')

        # 選択オプションの情報を取得
        @books = Book.select(:publish).distinct
    end

    def group_select
        @review = Review.new
        @authors = Author.all
    end

    def col_select2
        @book = Book.all
    end

    def dat_select
        @book = Book.find(1)
    end

    def col_radio
        @book = Book.new(publish: '技術評論社')
        @books = Book.select(:publish).distinct
    end

    def fields
        @user = User.find(1)
    end

    def list
        @books = Book.all
    end

    def multi
        # render layout: 'layout'
    end

    def relation
    end
    def download
    end
    def quest
    end

    def nest
        @msg = '今日も良い天気です。'
        render layout: 'child'
    end

    def partial_basic
        @book = Book.find(1)
    end

    def partial_col
        @books = Book.all
    end
end
