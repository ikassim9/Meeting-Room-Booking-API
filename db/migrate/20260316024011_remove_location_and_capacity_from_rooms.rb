class RemoveLocationAndCapacityFromRooms < ActiveRecord::Migration[8.1]
  def change
    remove_column :rooms, :location, :string
    remove_column :rooms, :capacity, :integer
  end
end
