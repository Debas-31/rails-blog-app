class Post < ApplicationRecord
  after_save :update_users_posts_counter

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def last_5_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_users_posts_counter
    author.increment!(:posts_counter)
  end
end
