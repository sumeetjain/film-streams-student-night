# Takes the student id and referral from each student and migrates their values to the referrals table

class MoveReferralDataToReferralsTable < ActiveRecord::Migration
    def change
   		Student.select('id, referral') do |student|
			student.referrals.create(
				:student_id => student.id,
				:referral_type => student.referral
		    )
  		end
    end
end
