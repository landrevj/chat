class CreateRootPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :root_posts do |t|
      t.string :subject
      t.text :body
      t.string :picture

      t.timestamps
    end
  end
end
