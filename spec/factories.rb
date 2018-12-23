FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password {"secretPassword"}
    password_confirmation {"secretPassword"}
  end

  factory :game do
  end

  factory :pawn do
    x_pos { 1 }
    y_pos { 1 }
    color { true }
  end
  
  factory :queen do
    x_pos { 3 }
    y_pos { 0 }
    color { true }
  end
  
  factory :king do
    x_pos { 4 }
    y_pos { 0 }
    color { true }
  end

  factory :rook do
  end

  factory :knight do
    x_pos { 6 }
    y_pos { 0 }
    color { true }
  end
end