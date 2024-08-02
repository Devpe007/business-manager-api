FactoryBot.define do
  factory :purchase_order do
    association :user
    association :customer
    association :product
    quantity { 3 }
    description { 'teste123' }
  end
end
