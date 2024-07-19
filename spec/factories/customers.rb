FactoryBot.define do
  factory :customer do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    mobile_number { FFaker::PhoneNumberBR.mobile_phone_number }
    address { FFaker::AddressBR.full_address }
    description { FFaker::LoremBR.phrase }
    association :user
  end
end
