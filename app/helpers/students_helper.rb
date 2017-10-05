module StudentsHelper

	# Database queries for referrals

  #Returns an array of all the referrals for a particular student
  def get_current_referrals(student_id)
    Referral.where(student_id: @student.id)
  end

  def create_referral_entry(student_id, referral_type)
    Referral.create!(
      :student_id => @student.id,
      :referral_type => referral_type.to_i
    )
  end

  def delete_referral_entry(student_id, referral_type)

  end

  def get_specific_referral(student_id, referral_type)
    Referral.where(["student_id = ? and referral_type = ?", student_id, referral_type]) 
  end

end
