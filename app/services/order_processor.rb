class OrderProcessor < ActiveInteraction::Base
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

  def execute
    sample_output
  end

  def sample_output
    {
      subtotal: "10.40",
      discount: "2.60",
      points: 20,
      message: "Thank you, GuestFirstName GuestLastName!",
    }
  end
end
