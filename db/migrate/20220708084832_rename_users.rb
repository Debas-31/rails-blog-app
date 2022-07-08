class RenameUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :posts_conunter, :posts_counter
  end
end
