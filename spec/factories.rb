FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :game do
  end

  factory :pawn do
    x_pos { 1 }
    y_pos { 1 }
    color { true }
  end
end