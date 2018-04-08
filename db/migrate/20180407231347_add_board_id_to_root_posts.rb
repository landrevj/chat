class AddBoardIdToRootPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :root_posts, :board, foreign_key: true
  end
end
