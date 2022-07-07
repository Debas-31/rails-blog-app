class Like < ApplicationRecord
  after_save :update_posts_like_counter

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  private

  def update_posts_like_counter
    post.increment!(:likes_counter)
  end
end
