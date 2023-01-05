class OrderProcessor < ActiveInteraction::Base
  MULTIPLIER = 2

  date_time :timestamp
  string :store_id
  string :guest_id
  string :transaction_id
  array :items do
    hash do
      string :sku
      decimal :price
      integer :quantity
    end
  end

  # Task 4. saves the details as an entry in the Order model
  def execute
    ActiveRecord::Base.transaction do
      create_order.tap do |order|
        items.each do |item|
          order.order_items.create!(
            sku: item[:sku],
            price: item[:price],
            quantity: item[:quantity],
          )
        end
      end
    end
  end

  private

  def create_order
    guest.orders.create!(
      store_id: store_id,
      transaction_id: transaction_id,
      timestamp: timestamp,
      discount: discount,
      points: point,
    )
  end

  def discount
    @discount ||= OrderDiscountCalculator.run!(items: items)
  end

  # Task 3. calculates the "point" awarded to the guest
  def point
    (MULTIPLIER * subtotal).floor
  end

  def subtotal
    total - discount
  end

  def total
    items.sum { |item| item[:price] * item[:quantity] }
  end

  def guest
    Guest.find_by(string_id: guest_id) || create_guest_with_fake_name
  end

  def create_guest_with_fake_name
    Guest.create(
      string_id: guest_id,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
    )
  end
end
