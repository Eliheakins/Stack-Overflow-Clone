require 'rails_helper'

RSpec.describe SortPostsByTrendingJob, type: :job do
  include ActiveJob::TestHelper

  after { clear_enqueued_jobs }

  
  it "enqueues the job" do
    expect {
      Post.trigger_sort_job
    }.to have_enqueued_job(SortPostsByTrendingJob)
  end

  it "executes the sorting logic" do
    expect(Post).to receive(:sort_by_trending)
    SortPostsByTrendingJob.perform_now
  end

  it "prioritizes posts from the past day over posts from previous days" do
    canned_time = Time.new("2024-09-31 01:00:00")
    post1 = FactoryBot.create(:post, :created_at => canned_time)
    post2 = FactoryBot.create(:post, :created_at => canned_time.yesterday)
    post1.reload
    post2.reload
    Post.sort_by_trending
    expect(post1.trend_score).to be > post2.trend_score
  end
end
