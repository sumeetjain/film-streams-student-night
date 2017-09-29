# Takes the student id and referral from each student and migrates their values to the referrals table

class MoveReferralDataToReferralsTable < ActiveRecord::Migration
    def up
   		Student.all.each do |student|
			Referral.create!(
				:student_id => student.id,
				:referral_type => Student.referrals[student.referral]
		    )
  		end
    end

    def down
    	Referral.destroy_all
    end
end
