class ChangeReferralFormatStudents < ActiveRecord::Migration
	def change
	    change_column :students, :referral, 'integer USING CAST(referral AS integer)'
	end
end
