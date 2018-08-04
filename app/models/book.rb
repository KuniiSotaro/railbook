class Book < ApplicationRecord
    after_destroy :history_book
    # attribute :price, :float
    validates :isbn, length: { is: 17}
    validates :title, presence: true, length: { minimum: 1, maximum: 100 }
    validates :price, numericality: { only_integer: true, less_than: 10000 }
    validates :publish, inclusion:{ in: ['技術評論社', '翔泳社', '秀和システム', '日経BP社', 'ソシム']}

    scope :gihyo, -> { where(publish: '技術評論社') }
    scope :newer, -> { order(published: :desc) }
    scope :top10, -> { newer.limit(10) }

    has_many :reviews
    # has_and_belongs_to_many :authors
    has_many :users, through: :reviews
    has_many :memos, as: :memoable

    # validates :isbn_valid?

    private
    # def isbn_valid?
    #     errors.add(:isbn, 'は正しい形式ではありません。')
    #      isbn = /\A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9x]{1}\z/
    # end

    def history_book
        logger.info('deleted: ' + self.inspect)
    end
end
