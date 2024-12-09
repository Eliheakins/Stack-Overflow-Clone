class Post < ApplicationRecord
  include UserAuthorizable
  belongs_to :user
  has_many :replies, dependent: :destroy

  belongs_to :tag, optional: true

  def self.trigger_sort_job
    SortPostsByTrendingJob.perform_later
  end
end
