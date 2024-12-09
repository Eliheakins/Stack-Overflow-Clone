require 'sidekiq/cron/job'

Sidekiq::Cron::Job.create(
  name: 'SortPostsByTrendingJob - every minute',
  cron: '* * * * *',
  class: 'SortPostsByTrendingJob'
)