class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  default_scope { order(updated_at: :desc) }

  enum status: { draft:0, published: 1, deleted: 2}
end
