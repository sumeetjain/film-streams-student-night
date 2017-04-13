class Validate

	def initialize(params)
		@email = params[:email]
		@email_confirmation = params[:email_confirmation]
	end

	def validation
		is_a_valid_email? and emails_match?
	end

	def is_a_valid_email?
  	(@email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
	end

	def emails_match?
		@email == @email_confirmation
	end

end