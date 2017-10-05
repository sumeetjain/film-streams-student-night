class Referral < ActiveRecord::Base
	belongs_to :student

	
	enum referral_type: {
		'From a friend'             => 0,
		'From my teacher'           => 1,
		'From a family member'		=> 2,
		"Film Streams' enewsletter or email" => 3,
		'Internet Search'			=> 4,
		'Social media'              => 5,
		"Radio"						=> 6,
		"Film Streams' website"     => 7,
		"Film Streams' Flyer"		=> 8,
		'other source'				=> 999

	}

	# Adds a referral source
	def add_referral(student_id, referral_type)

	end

	# Removes a referral source
	def remove_referral(student_id, referral_type)

	end

	# Checks to see if a referral source has already been created for a student
	def check_referral_existance(student_id, referral_type)

	end

	def get_referrals_for_student(student_id)
		return Referral.where(student_id: student_id)
	end

	def get_specific_referral(student_id, referral_type)
        return Referral.where(["student_id = ? and referral_type = ?",student_id, referral_type])
	end

	def build_referral_checkbox_group(student_id)

	    # past_referrals.each do |referral| 
	    #  	used_referrals.push(referral.referral_type) 
	    # end
		returnHTML = ""
	    Referral.referral_types.each do |referral|
	      	returnHTML += '<div> #{referral[0]} <input type="checkbox" name="#{referrals[]" value="#{referral[1]}"> </div> '
	    end
		return returnHTML
	end
end


# 	      	if get_referrals_for_student(student_id).include?(referral[0]) 
# 	        <div>
# 	          <%= referral[0] 
# 	          <input type="checkbox" name="referrals[]" value="<%= referral[1] " checked>
# 	        </div>
# 	      	else 
# 	        <div>
# 	          <%= referral[0] 
# 	          <input type="checkbox" name="referrals[]" value="<%= referral[1] ">
# 	        </div>
# 	       	end 
# 	    	end 
# 	  </div>
# 	  	used_referrals.clear 
# 	end


# Previous Versions Enums

 #  enum referral: {
	# 	'From a friend'             => 0,
	# 	'From my teacher'           => 1,
	# 	"Film Stream's enewsletter" => 2,
	# 	'Internet Search'			=> 3,
	# 	'Social media'              => 4,
	# 	"Film Stream's website"     => 5,
	# 	'other source'				=> 999

	# }