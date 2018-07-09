class RecordController < ApplicationController
    def find
        @books = Book.find([2, 5, 10])
        render 'hello/list'
    end

    def find_by
        @book = Book.find_by(publish: '技術評論社', price: 2980)
        # render 'books/show'
    end

    def where
        @books = Book.where(published: '2016-06-01'..'2016-12-31')
        render 'hello/list'
    end

    def ph1
        @books = Book.where('publish = ? AND price >= ?', params[:publish], params[:price])
        render 'hello/list'
    end

    # 別のph1の記述(名前付きパラメーター)
    # def ph1
    #     @books = Book.where('publish = :publish AND price >= :price', publish: params[:publish], price: params[:price])
    #     render 'hello/list'
    # end

    def not
        @books = Book.where.not(isbn: params[:id])
        render 'books/index'
    end

    def where_or
        @books = Book.where(publish: '技術評論社').or(Book.where('price > 2000'))
        render 'hello/list'
    end

    def order
        @books = Book.where(publish: '技術評論社').order(published: :desc, price: :asc)
        render 'hello/list'
    end

    def reorder
        @books = Book.order(:publish).reorder(nil)
        render 'books/index'
    end

    def select
        @books = Book.where('price >= 2000').select(:title, :price)
        render 'hello/list'
    end

    def select2
        @pubs = Book.select(:publish).distinct.order(:publish)
    end

    def offset
        @books = Book.order(published: :desc).limit(3).offset(4)
        render 'hello/list'
    end

    def page
        page_size = 3 #ページ当たりの表示件数
        page_num = params[:id] == nil? 0 : params[:id].to_i - 1 #現在のページ数
        @books = Book.order(published: :desc).limit(page_size).offset(page_size * page_num)
        render 'hello/list'
    end

    def last
        @books = Book.order(published: :desc).last
        render 'hello/list'
    end
end
