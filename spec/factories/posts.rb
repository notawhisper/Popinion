FactoryBot.define do
  factory :post do
    content { "MyString" }
    user { nil }
    room { nil }
  end
end
