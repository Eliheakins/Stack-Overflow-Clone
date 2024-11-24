class Post < ApplicationRecord
  include UserAuthorizable
  belongs_to :user
  has_many :replies, dependent: :destroy

  belongs_to :tag, optional: true
  has_many :votes, as: :votable, dependent: :destroy

  def score
    votes.sum(:value) # Calculates the total score based on upvotes and downvotes
  end
end
