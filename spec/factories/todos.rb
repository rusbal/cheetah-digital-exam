FactoryBot.define do
  factory :todo do
    title { Faker::Company.bs }
  end
end
