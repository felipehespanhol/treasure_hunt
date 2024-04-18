FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_user_#{n}@email.com" }
  end
end
