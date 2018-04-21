class AddPropertiesToChildPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :child_posts, :properties, :jsonb, null: false, default: {}
    add_index :child_posts, :properties, using: :gin
  end
end
