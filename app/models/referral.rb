class Referral < ActiveRecord::Base
	belongs_to :student
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