class Post < ApplicationRecord
  include UserAuthorizable
  belongs_to :user
  has_many :replies, dependent: :destroy

  belongs_to :tag, optional: true

  has_many :saved_posts,  dependent: :destroy
  has_many :users_saved, through: :saved_posts, source: :user
end
