class RecordController < ApplicationController
    # レコードの検索
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

    def def_scope
        render plain: Review.all.inspect
    end

    def count
        cnt = Book.where(publish: '技術評論社').count
        render plain: "#{cnt}件です。"
    end

    def average
        price = Book.where(publish: '技術評論社').average(:price)
        render plain: "平均価格は#{price}円です。"
    end

    def literal_sql
        @books = Book.find_by_sql(['SELECT publish, AVG(price) AS avg_price FROM "books" GROUP BY publish HAVING AVG(price) >= ?', 2500])
        render 'record/groupby'
    end

    # レコードの登録・更新・削除
    def update_all
        cnt = Book.where(publish: '技術評論社').update_all(publish: 'Gihyo')
        render plain: "#{cnt}件のデータを更新しました。"
    end

    def update_all2
        cnt = Book.order(:published).limit(5).update_all('price = price * 0.8')
        render plain: "#{cnt}件のデータを更新しました。"
    end

    def destroy_all
        Book.where.not(publish: '技術評論社').destroy_all
        render plain: '削除完了'
    end

    def transact
        Book.transaction do
            b1 = Book.new({isbn: '978-4-7741-5067-3', title: 'Rubyポケットリファレンス',
                price: 2580, publish: '技術評論社', published:'2017-04-17'})
            b1.save!
            raise '例外発生：処理はキャンセルされました。'
            b2 = Book.new({isbn: '978-4-7741-5067-5', title: 'Tomcatポケットリファレンス',
                price: 2500, publish: '技術評論社', published: '2017-05-10'})
            b2.save!
        end
        render plain: 'トランザクションは成功しました。'
    rescue => e
        render plain: e.message
    end

    def enum_rec
        @review = Review.find(1)
        @review.published!
        render plain: 'ステータス：' + @review.status
    end

    def keywd
        @search = SearchKeyword.new
    end

    def keywd_process
        @search = SearchKeyword.new(params.require(:search_keyword).permit(:keyword))
        if @search.valid?
            render plain: @search.keyword
        else
            render plain: @search.errors.full_messages[0]
        end
    end

    def belongs
        @review = Review.find(3)
    end

    def hasmany
        @book = Book.find_by(isbn: '978-4-7741-8411-1')
    end

    def hasone
        @user = User.find_by(username: 'yyamada')
    end

    def has_and_belongs
        @book = Book.find_by(isbn: '978-4-7980-4803-1')
    end

    def has_many_through
        @user = User.find_by(username: 'isatou')
    end

    def memorize
        @book = Book.find(1)
        # 書籍情報に関するメモを登録
        @memo = @book.memos.build({ body: 'あとで買う' })
        if @memo.save
            render plain: 'メモを作成しました。'
        else
            render plain: @memo.errors.full_messages[0]
        end
    end

    def assoc_includes
        @books = Book.includes(:reviews).all
    end

end
