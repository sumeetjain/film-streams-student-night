class Student < ActiveRecord::Base

	has_many :attendances
	belongs_to :school
	
	validates :name, presence: true
	validates :school, presence: true
	validates :year, presence: true
	validates :zip, presence: true
	validates :referral, presence: true

  validates :email, confirmation: true
	validates :email, presence: true,  uniqueness: { case_sensitive: false },
					  format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

	def validates_email
		if Student.where(email: email).exists?
    	return true
  	end
  end

  # Enum's
  
  enum year: {
		'Kindergarten'             => 0,
		'1st'                      => 1,
		'2nd'                      => 2,
		'3rd'                      => 3,
		'4th'                      => 4,
		'5th'                      => 5,
		'6th'                      => 6,
		'7th'                      => 7,
		'8th'                      => 8,
		'Freshman in High School'  => 9,
		'Junior in High School'    => 10,
		'Sophomore in High School' => 11,
		'Senior in High School'    => 12,
		'Freshman in  college'     => 13,
		'Junior in college'        => 14,
		'Sophomore in college'     => 15,
		'Senior in college'        => 16,
		'Grad'                     => 17,
		'other'										 => 999
	}

	  enum referral: {
		'From a friend'             => 0,
		'From my teacher'           => 1,
		"Film Stream's enewsletter" => 2,
		'Internet Search'						=> 3,
		'Social media'              => 4,
		"Film Stream's website"     => 5,
		'other source'							=> 999

	}

end