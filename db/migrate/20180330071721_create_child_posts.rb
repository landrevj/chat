class CreateChildPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :child_posts do |t|
      t.text :body
      t.string :picture
      t.integer :root_post_id

      t.timestamps
    end
  end
end
