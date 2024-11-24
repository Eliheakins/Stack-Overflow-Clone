FactoryBot.define do
    factory :reply do
      content { "This is a sample reply." }
      #text { "This is a sample reply." }
      user
      post
    end
  end
  