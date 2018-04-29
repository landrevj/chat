class RemoveUsersFromRooms < ActiveRecord::Migration[5.1]
  def change
    remove_reference( :rooms, :user, index: true)
  end
end
