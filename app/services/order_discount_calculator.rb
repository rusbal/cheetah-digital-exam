class OrderDiscountCalculator < ActiveInteraction::Base
  MULTIPLIER = 2

  array :items do
    hash do
      string :sku
      decimal :price
      integer :quantity
    end
  end

  # Task 2. computes and applies the discount (if it reaches a minimum subtotal)
  def execute
    total_at_least_10_usd_discount     = total >= 10 ? (total * 0.20) : 0.0
    purchase_contains_sku_ccc_discount = purchase_contains_sku_ccc? ? 2 : 0.0

    [
      total_at_least_10_usd_discount,
      purchase_contains_sku_ccc_discount
    ].max
  end

  def total
    items.sum { |item| item[:price] * item[:quantity] }
  end

  def purchase_contains_sku_ccc?
    items.find { |item| item[:sku] == 'CCC' }.present?
  end
end
