class AddLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location, :integer
  end
end
