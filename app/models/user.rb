class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy
end
