FactoryBot.define do
    factory :post do
      title { "Sample Post" }
      text { "This is a sample post." }
      user # Assumes you already have a factory for `User`
    end
  end
  