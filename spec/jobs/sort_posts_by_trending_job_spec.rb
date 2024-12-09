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
    post1 = double("Post")
    post2 = double("Post")
    canned_time = Time.new("2024-09-31 01:00:00")
    expect(post1).to receive(:created_at).and_return(canned_time)
    expect(post2).to receive(:created_at).and_return(canned_time.yesterday)
  end
end
