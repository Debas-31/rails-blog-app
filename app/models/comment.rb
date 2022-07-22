class Comment < ApplicationRecord
  after_save :update_posts_comments_counter

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, foreign_key: 'post_id', class_name: 'Post'

  private

  def update_posts_comments_conuter
    post.increment!(:comments_counter)
  end
end
