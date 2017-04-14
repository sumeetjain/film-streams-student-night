class Student < ActiveRecord::Base
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

  enum years: [:Kindergarten, :1st, :2nd, :3rd, :4th, :5th, :6th, :7th, :8th, :Freshman in High School, :Junior in High School, :Sophomore in High School, :Senior in High School, :Freshman in  college, :Junior in college, :Sophomore in college, :Senior in college, :Grad]


end