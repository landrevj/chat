class AddOwnerToRooms < ActiveRecord::Migration[5.1]
  def change
    add_reference :rooms, :user, foreign_key: true, column: :owner_id
  end
end
