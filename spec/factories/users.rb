FactoryBot.define do
  factory :user do
    email_address { "user#{rand(1000)}@example.com" }
    password { "password" }
    user_type { :regular }
    username { "user" }
  end
end
