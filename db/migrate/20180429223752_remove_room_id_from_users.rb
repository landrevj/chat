class RemoveRoomIdFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_reference( :users, :rooms, index: true)
  end
end
