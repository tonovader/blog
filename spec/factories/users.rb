FactoryBot.define do
  factory :user, aliases: [:antonio] do
    name { 'NotAbdiel' }
    email { 'abykings1@hotmail.com' }
    password { 'str4wberryF1elds1!' }

    trait :sequential_user do
      sequence(:name) { |n| "User #{n}" }
      sequence(:email) { |n| "user#{n}@test.com" }
    end
  end

  factory :tony_stark, class: 'User' do
    name { 'aaaa' }
    email { 'aaa@a.com' }
    password { 'str4wberryF1elds2!' }
  end

  factory :bruce_banner, class: 'User' do
    name { 'Bruce' }
    email { 'bbb@b.com' }
    password { 'str4wberryF1elds3!' }
  end

  factory :steve_rogers, class: 'User' do
    name { 'Steve R' }
    email { 'Steve@rogers.com' }
    password { 'str4wberryF1elds3!' }
  end
end
