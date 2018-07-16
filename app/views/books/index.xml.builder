# <books>要素を生成
xml.books do
    # @booksをもとに、順に<book>要素を生成
    @books.each do |b|
        xml.book(isbn: b.isbn) do
            xml.title(b.title)
            xml.price(b.price)
            xml.publish(b.publish)
            xml.published(b.published)
            xml.dl(b.dl)
        end
    end
end
