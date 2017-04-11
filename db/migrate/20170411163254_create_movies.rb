class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.time :time
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
