class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post
  enum vote_type: { down: 0, up: 1 }

  validates :vote_type, presence: true
  scope :up, -> { where(vote_type: :up) }
  scope :down, -> { where(vote_type: :down) }
end
