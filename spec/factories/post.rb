FactoryBot.define do
    factory :post do
      title { "Sample Post" }
      text { "Test Content for Post" }
      association :user 
    end
  end
  