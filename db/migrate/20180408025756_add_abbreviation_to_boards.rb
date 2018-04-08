class AddAbbreviationToBoards < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :abbreviation, :string, unique: true
  end
end
