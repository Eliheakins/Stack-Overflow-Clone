class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :reply
end
