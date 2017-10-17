class Referral < ActiveRecord::Base
	belongs_to :student

	# Rails enumeration for referral types
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

	# Psuedo enum used for translating queries
	referral_types = {
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

	# Returns a count of each referral type for a particular event
	def self.get_referrals_by_event(event_id)
		@conn = PGconn.connect(:dbname =>  "film-streams-student-night_development")
		@get_referrals_from_event = @conn.exec("SELECT COUNT(*) AS total, referral_type FROM attendances JOIN referrals ON attendances.student_id = referrals.student_id WHERE attendances.event_id = #{event_id} GROUP BY referral_type ORDER BY total DESC;")
	    @referrals = {}

    	@get_referrals_from_event.each do |ref|
    		referral_type = referral_types.key(ref['referral_type'].to_i)
    		total = ref['total']

    		@referrals[referral_type] = total
      	end
    return @referrals
    end
end