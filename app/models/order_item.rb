class OrderItem < ApplicationRecord
  belongs_to :order

  validates :sku, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
