class AddUserIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :root_posts, :user, foreign_key: true
    add_reference :child_posts, :user, foreign_key: true
  end
end
