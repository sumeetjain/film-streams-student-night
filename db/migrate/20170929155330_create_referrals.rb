class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.integer :referral_type
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
