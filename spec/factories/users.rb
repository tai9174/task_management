FactoryBot.define do
  factory :user do
    name { 'test_name' }
    email { 'test_email@gmail.com' }
    password{'test_password'}
    created_at{Date.today}
    admin{false}
  end

  factory :admin_user, class: User do
    name { 'admin_name' }
    email { 'admin_email@gmail.com' }
    password{'admin_password'}
    created_at{Date.today}
    admin{true}
  end
end
