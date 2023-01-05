class Order < ApplicationRecord
  belongs_to :guest
  has_many :order_items

  validates :store_id, presence: true
  validates :transaction_id, presence: true
  validates :timestamp, presence: true
  validates :discount, presence: true
  validates :points, presence: true

  def subtotal
    @subtotal ||= total - discount
  end

  def total
    @total ||= order_items.sum(&:total_price)
  end
end
