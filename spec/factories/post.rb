FactoryBot.define do
  factory :post do
    title { "MyString" }
    text { "MyString" }
    association :user
    tag_id { nil } # or set to a valid tag ID if needed
  end
end
