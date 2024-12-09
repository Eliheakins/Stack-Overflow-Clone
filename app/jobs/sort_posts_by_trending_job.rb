class SortPostsByTrendingJob < ApplicationJob
  queue_as :default
  
  def perform(*args)
    Post.sort_by_trending
  end
end
