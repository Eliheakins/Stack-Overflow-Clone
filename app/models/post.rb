class Post < ApplicationRecord
  include UserAuthorizable
  belongs_to :user
  has_many :replies, dependent: :destroy

  belongs_to :tag, optional: true

  def self.search_by_query(query, tag_ids = [])
    words = query.split.map { |word| sanitize_sql_like(word) }
    match_conditions = words.map do |word|
      "(LOWER(title) LIKE LOWER(:word) OR LOWER(text) LIKE LOWER(:word))"
    end.join(" OR ")
    match_count_query = words.map do |word|
      "(CASE WHEN LOWER(title) LIKE '%#{word}%' OR LOWER(text) LIKE '%#{word}%' THEN 1 ELSE 0 END)"
    end.join(" + ")
    match_count_query = "0" if match_count_query.blank?
    base_query = Post.select("posts.*, (#{match_count_query}) AS match_count")
                     .where(match_conditions, word: "%#{words.join('%')}%")

    if tag_ids.present?
      base_query = base_query.joins(:tag).where(tags: { id: tag_ids })
    end
    base_query.order("match_count DESC")
  end
end
