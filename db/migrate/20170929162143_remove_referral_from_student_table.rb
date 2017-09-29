class RemoveReferralFromStudentTable < ActiveRecord::Migration
  def change
    remove_column :students, :referral, :integer
  end
end
