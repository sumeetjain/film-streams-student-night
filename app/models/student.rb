class Student < ActiveRecord::Base
	attr_accessor :newsletter

	has_many :referrals
	has_many :attendances
	belongs_to :school
	
	validates_associated :referrals, presence: true
	validates :name, presence: true
	validates :school, presence: true
	validates :year, presence: true
	validates :zip, presence: true, :length => { :is => 5 }
	validates :email, confirmation: true
	validates :email, presence: true,  uniqueness: { case_sensitive: false },
					  format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

	# Adds referrals for a new student 
	def add_referrals(referrals)
		if !referrals == nil
			referrals.each do |r|
	      		Referral.create!(student_id: self.id, referral_type: r.to_i)
	  	    end
	  	end
	end

  	def update_referrals(new_referrals)
  	    # Remove all this student's referrals from the DB.
   	    self.referrals.destroy_all

	    # Add new_referrals to this student.
		if !new_referrals == nil
	        new_referrals.each do |r|
	      		Referral.create!(student_id: self.id, referral_type: r.to_i)
	  	    end
	  	end
    end

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
		'other'					   => 999
	}


end