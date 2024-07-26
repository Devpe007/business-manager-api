FactoryBot.define do
  factory :product do
    name { FFaker::Product.product_name }
    price { 50 }
    cost { 15 }
    quantity { 200 }
    inventory { true }
  end
end
