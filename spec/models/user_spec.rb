require 'rails_helper'

RSpec.describe User, type: :model do

	describe '#User should be valid if' do

	  before(:each) do
  	  @user = User.new(name: "Example", password: "moocows", password_confirmation: "moocows", email: "moogle@doogle.com")	
	  end

    it 'all params are valid' do
    # Exercise / Validation
      expect(@user.valid?).to equal (true)
    end

    it 'name is nonempty' do
    # Setup
    	@user.name = " "
    # Exercise / Validation
      expect(@user.valid?).to equal (false)
    end

  	it 'email conforms to regex' do
	  	# Setup
			valid_addresses = %w[user@example.com User@foo.COM A_US-ER@foo.bar.org
													 first.last@foo.jp alice+bob@baz.cn]
		# Execute / Validation
			valid_addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user.valid?).to equal (true)
			end
		end

  	it 'lacks improper regex' do
  		# Setup
			invalid_addresses = %w[lskolksndg bork@ derp.corp moo,moo,moo 
		 												user.name.@example foo@bar_baz.com foo@bar+dong.mom]
		 	# Execute / Validation
			invalid_addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user.valid?).to equal (false)
			end
		end

  	it 'not a duplicate email' do
  		# Setup
  		dup_user = @user.dup
  		dup_user.email = @user.email.upcase
  		@user.save
  		# Execute / Validation
  		expect(dup_user.valid?).to equal (false)
  	end

  	it 'password in valid form' do
  		# Setup
  		valid_passwords = %w[moomoo cowcow 12er34ow mpx3Ewe password]
  		# Execute / Validation
	  	valid_passwords.each do |valid_password|
	  		
	  		@user.password = valid_password
	  		@user.password_confirmation = valid_password
	  		debugger
	  		expect(@user.valid?).to equal (true)
	  	end
	  end

  	it 'is invalid if password empty' do
	  	# Setup
  		@user.password = "  "
  		@user.password_confirmation = "  "
  		#Execute / Validation
  		expect(@user.valid?).to equal (false)
  	end

  	it 'is invalid if too short' do
	  	# Setup
	  	@user.password = "ww"
	  	@user.password_confirmation = "ww"
	  	#Execute / Validation
	  	expect(@user.valid?).to equal (false)
  	end
  end
end
