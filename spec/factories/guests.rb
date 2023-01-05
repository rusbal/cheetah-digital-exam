FactoryBot.define do
  factory :guest do
    string_id { "54D0D284B0" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
