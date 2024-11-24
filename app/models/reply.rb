class Reply < ApplicationRecord
  include UserAuthorizable
  belongs_to :user
  belongs_to :post
  belongs_to :parent_reply, class_name: "Reply", optional: true
  has_many :replies, foreign_key: :parent_reply_id, class_name: "Reply", dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy


  validates :text, presence: true
  def score
    votes.sum(:value)
  end
end
