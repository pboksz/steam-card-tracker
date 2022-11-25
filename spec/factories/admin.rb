FactoryBot.define do
  factory :admin do
    email { 'e@mail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
