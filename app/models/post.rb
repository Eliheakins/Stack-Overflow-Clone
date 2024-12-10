class Post < ApplicationRecord
  include UserAuthorizable
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  #has_many :voters, through: :votes, source: :user
  has_many :replies, dependent: :destroy

  belongs_to :tag, optional: true
end
