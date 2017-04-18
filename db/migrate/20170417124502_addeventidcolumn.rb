class Addeventidcolumn < ActiveRecord::Migration
  def change
    add_column :attendances, :event_id, :string
  end
end
