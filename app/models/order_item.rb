class OrderItem < ApplicationRecord
  belongs_to :order

  validates :sku, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  def total_price
    price * quantity
  end
end
