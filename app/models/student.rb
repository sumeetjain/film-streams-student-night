class Student < ActiveRecord::Base
	attr_accessor :newsletter

	has_many :attendances
	belongs_to :school
	
	validates :name, presence: true
	validates :school, presence: true
	validates :year, presence: true
	validates :zip, presence: true, :length => { :is => 5 }
	validates :referral, presence: true

  validates :email, confirmation: true
	validates :email, presence: true,  uniqueness: { case_sensitive: false },
					  format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }


	def validates_email
		if Student.where(email: email).exists?
    	return true
  	end
  end

  def add_to_mailchimp
  	if newsletter == "1"
	  	begin
	  		Gibbon::Request.lists(ENV["MAILCHIMP_LIST_ID"]).members.create(body: {email_address: email, status: "subscribed", merge_fields: {FNAME: first_name, LNAME: last_name}})
	  	rescue Gibbon::MailChimpError => e
	  		# Deal with the error in any way? Undecided.
	  	end
	  end
  end

  def first_name
  	name.split(" ").first
  end

  def last_name
  	name_arr = name.split(" ")
  	name_arr[1..name_arr.length].join(" ")
  end

  # Enum's
  
  enum year: {
		'Kindergarten'             	=> 0,
		'1st'                     	=> 1,
		'2nd'                      	=> 2,
		'3rd'                     	=> 3,
		'4th'                      	=> 4,
		'5th'                      	=> 5,
		'6th'                     	=> 6,
		'7th'                      	=> 7,
		'8th'						=> 8,
		'9th'  						=> 9,
		'10th'   					=> 10,
		'11th' 						=> 11,
		'12th'						=> 12,
		'College Freshman'			=> 13,
		'College Sophomore'        	=> 14,
		'College Junior'			=> 15,
		'College Senior'			=> 16,
		'Grad'						=> 17,
		'Teacher'					=> 18,
		'other'						=> 999
	}

end