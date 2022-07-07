class Post < ApplicationRecord
  after_save :update_users_posts_counter

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def last_5_comments
    comments.order(created_at: :desc).limit(5)
  end

  validate :title , presence: true, allow_blank: false, length: { maximum: 250 }
  validate :comments_counter, numericality: { only_integer: true, greater_than: -1 }
  validate :likes_counter, numericality: { only_integer: true, greater_than: -1 }

  private

  def update_users_posts_counter
    author.increment!(:posts_counter)
  end
end
