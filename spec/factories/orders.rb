FactoryBot.define do
  factory :order do
    guest
    timestamp { "2023-01-05 20:39:30" }
    store_id { "MyString" }
    transaction_id { "MyString" }
    discount { "9.99" }
    points { 1 }
  end
end
