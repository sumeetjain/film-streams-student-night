class Referral < ActiveRecord::Base
	belongs_to :student


	enum referral_type: {
		'From a friend'             => 0,
		'From my teacher'           => 1,
		"Film Stream's enewsletter" => 2,
		'Internet Search'			=> 3,
		'Social media'              => 4,
		"Film Stream's website"     => 5,
		'other source'				=> 999

	}

end
