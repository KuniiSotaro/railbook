class RecordController < ApplicationController
    def last
        @book = Book.order(published: :desc).last
        render 'books/show'
    end

    def groupby
        @books = Book.select('publish, AVG(price) AS avg_price').group(:publish)
    end

    def havingby
        @books = Book.select('publish, AVG(price) AS avg_price').group(:publish).having('AVG(price) >= ?', 2500)
        render 'record/groupby'
    end

    def where2
        @books = Book.all
        @books.where!(publish: '技術評論社')
        @books.order!(:published)
        render 'books/index'
    end

    def unscope
        @books = Book.where(publish: '技術評論社').order(:price).select(:isbn, :title).unscope(:where, :select)
        render 'books/index'
    end

    def none
        case params[:id]
        when 'all'
            @books = Book.all
        when 'new'
            @books = Book.order('published DESC').limit(5)
        when 'cheap'
            @books = Book.order(:price).limit(5)
        else
            @books = Book.none
        end
        render 'books/index'
    end

    def pluck
        render plain: Book.where(publish: '技術評論社').pluck(:title, :price)
    end

    def exists
        flag = Book.where(publish: '新評論社').exists?
        render plain: "存在するか？：#{flag}"
    end

    def scope
        @books = Book.gihyo.top10
        render 'hello/list'
    end
end
