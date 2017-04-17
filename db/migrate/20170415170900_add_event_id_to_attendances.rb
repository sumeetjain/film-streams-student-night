class AddEventIdToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :event_id, :Integer
  end
end
