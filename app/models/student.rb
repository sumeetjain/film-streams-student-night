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


end