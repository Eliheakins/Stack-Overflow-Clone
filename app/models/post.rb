class Post < ApplicationRecord
  include UserAuthorizable
  belongs_to :user
  has_many :replies, dependent: :destroy

  belongs_to :tag, optional: true

  DECAY = 0.1

  def self.sort_by_trending
    Post.find_each do |post|
      age_in_hours = (Time.now - post.created_at) / 3600
      popularity = ([post.votes, 10].max * 2) + post.replies.count
      recency = Math.exp(-DECAY * Math.sqrt(age_in_hours))
      post.trend_score = popularity * recency
      post.save!
    end
  end

  def self.trigger_sort_job
    SortPostsByTrendingJob.perform_later
  end
end
