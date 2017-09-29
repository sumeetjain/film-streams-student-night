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

end


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