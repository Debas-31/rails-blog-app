class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy

  validate :name, presence: true, allow_blank: false
  validate :posts_conunter, numericality: { only_integer: true, greater_than: -1 }

  def last_3_posts
    posts.order(created_at: :desc).limit(3)
  end
end
