class Comment < ApplicationRecord
  after_save :update_posts_comments_counter

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  private

  def update_posts_comments_conuter
    post.increment!(:comments_counter)
  end
end
