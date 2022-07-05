class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.intger :comments_counter
      t.intger :likes_counter
      t.timestamps
    end
  end
end
