FactoryBot.define do
  factory :user do
    name { "testuser" + "#{User.all.size + 1}" }
    email { "test" + "#{User.all.size + 1}" + "@test.com" }
    password { "password" }
  end
end
