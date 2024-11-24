FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(specifier: 8) }
    password { 'password' }
    firstname { 'User' }
    lastname { 'Name' }
    email { Faker::Internet.unique.email }
    role { 'student' }
  end
end
