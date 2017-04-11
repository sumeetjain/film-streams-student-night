class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :email
      t.string :name
      t.string :school
      t.integer :year
      t.integer :zip
      t.string :referral

      t.timestamps null: false
    end
  end
end
