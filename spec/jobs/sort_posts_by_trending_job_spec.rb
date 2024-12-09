require 'rails_helper'

RSpec.describe SortPostsByTrendingJob, type: :job do
  include ActiveJob::TestHelper

  after { clear_enqueued_jobs }

  
  it "enqueues the job" do
    expect {
      Post.trigger_sort_job
    }.to have_enqueued_job(SortPostsByTrendingJob)
  end

  it "prioritizes posts from the past day over posts from previous days" do
    canned_time = Time.new("2024-09-31 01:00:00")
    post1 = FactoryBot.build(:post, :created_at => canned_time)
    post2 = FactoryBot.build(:post, :created_at => canned_time.yesterday)
  end
end
