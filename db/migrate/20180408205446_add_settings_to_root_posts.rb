class AddSettingsToRootPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :root_posts, :settings, :jsonb, null: false, default: {}
    add_index :root_posts, :settings, using: :gin
  end
end
