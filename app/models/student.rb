class Student < ActiveRecord::Base

	has_many :attendances
	
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
		'Grad'                     => 17
	}

	enum school: {
		'ALHS' =>	1,
		'Arizona State' =>	2,
		'Ball State' =>	3,
		'Bellevue East High School' =>	4,
		'Bellevue West' =>	5,
		'Bellvue' =>	6,
		'Bellvue East High School' =>	7,
		'Blair High School' =>	8,
		'Boston College' =>	9,
		'Brownell Talbot' =>	10,
		'BYU' =>	11,
		'Central' =>	12,
		'Chadron State College' =>	13,
		'Clarkson College' =>	14,
		'Colgate University' =>	15,
		'College of St. Benedict' =>	16,
		'Colorado College' =>	17,
		'Creighton Dental' =>	18,
		'Creighton Med' =>	19,
		'Creighton Prep' =>	20,
		'Creighton University' =>	21,
		'Deep Springs College' =>	22,
		'DePaul' =>	23,
		'drake U' =>	24,
		'Duchesne' =>	25,
		'Elkhorn High School' =>	26,
		'Grace University' =>	27,
		'Gross' =>	28,
		'Harvard' =>	29,
		'Iowa Western' =>	30,
		'ISU' =>	31,
		'IWCC' =>	32,
		'King Science' =>	33,
		'Laney College' =>	34,
		'Law' =>	35,
		'lincoln U' =>	36,
		'Loyola' =>	37,
		'Loyola Marymount' =>	38,
		'Loyola New Orleans' =>	39,
		'MEC' =>	40,
		'Mercy High School' =>	41,
		'Metro Community College' =>	42,
		'Miami U' =>	43,
		'Millard Learning Center' =>	44,
		'Millard North' =>	45,
		'Millard West' =>	46,
		'Mt. Michael' =>	47,
		'Nebraska Methodist College' =>	48,
		'Nebraska Wesleyan University' =>	49,
		'New School University' =>	50,
		'New York University' =>	51,
		'North Park University' =>	52,
		'Notre Dame' =>	53,
		'NWU' =>	54,
		'NYU' =>	55,
		'Omaha Central' =>	56,
		'Omaha South' =>	57,
		'Papillion-La Vista' =>	58,
		'R.M. Marrs' =>	59,
		'Regis' =>	60,
		'Rice' =>	61,
		'Rockhurst University' =>	62,
		'Sandberg Inst.' =>	63,
		'SDSH' =>	64,
		'Skutt Catholic' =>	65,
		'SLU' =>	66,
		'South High' =>	67,
		'St Mary College' =>	68,
		'St. Olof College' =>	69,
		'Stevens Inst' =>	70,
		'Tulane' =>	71,
		'UC Berkely' =>	72,
		'Union College' =>	73,
		'Univerity of Michigan' =>	74,
		'University of Iowa' =>	75,
		'University of Maryland' =>	76,
		'University of Minnesota, Mineapolis' =>	77,
		'University of Puget Sound' =>	78,
		'University of Wisconsin at Madison' =>	79,
		'University of Wisconsin Stout' =>	80,
		'UNK' =>	81,
		'UNL' =>	82,
		'UNMC' =>	83,
		'UNO' =>	84,
		'UNO-PKI' =>	85,
		'USC' =>	86,
		'UW Madison' =>	87,
		'Wash U in St. Louis' =>	88,
		'Washburn University' =>	89,
		'Wayne SU' =>	90,
		'Westside' =>	91,
		'Westside Middle School' =>	92,
		'Wheaton College' =>	93,
		'WMU' =>	94,
		'Xavier U' =>	95
	}

	  enum referral: {
		'From a friend'             => 0,
		'From my teacher'           => 1,
		'From my school'            => 2,
		'Internet Search'						=> 3,
		'Social media'              => 4,
		"Film Stream's website"     => 5,

	}

end