FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "testemail#{n}@gmail.com"
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end

  factory :game do
  end
end