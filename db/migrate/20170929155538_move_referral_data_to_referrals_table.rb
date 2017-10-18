# Takes the student id and referral from each student and migrates their values to the referrals table

class MoveReferralDataToReferralsTable < ActiveRecord::Migration
  
  def updates

    # Previous Versions Enums once located in the student model.
    old_referral_types = {
      'From a friend'             => 0,
      'From my teacher'           => 1,
      "Film Stream's enewsletter" => 2,
      'Internet Search'           => 3,
      'Social media'              => 4,
      "Film Stream's website"     => 5,
      'other source'              => 999
    }

 		Student.all.each do |student|
		  Referral.create!(
			  :student_id => student.id,
			  :referral_type => update_referral_value(old_referral_types[student.referral])
	    )
		end
  end

  def down
  	Referral.destroy_all
  end

  # Takes in the referral type and updates it with a new value if it was one of the enum values which was updated
  def update_referral_value(referral_type_id)
    if referral_type_id == 2
      return 3
    elsif referral_type_id == 3
      return 4
    elsif referral_type_id == 4
      return 5
    elsif referral_type_id == 5
      return 7
    else 
      return referral_type_id    
    end    
  end
end

  