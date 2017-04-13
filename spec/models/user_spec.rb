require 'rails_helper'

RSpec.describe User, type: :model do

	$user = User.new(name: "Example User", password: "moocows",
					 password_confirmation: "moocows", email: "moogle@doogle.com")	

	describe '#should be valid' do
    it 'returns true if valid' do
    ## Setup 

    ## Exercise / Validation
      expect($user.valid?).to equal (true)
    end
  end

  describe '#name only valid if present' do
    it 'is not valid if name is empty' do
    ## Setup 
    user = User.new(name: "  ")
    ## Exercise / Validation
      expect(user.valid?).to equal (false)
    end
  end

  describe '#allows valid email' do
  	it 'is valid if conforms to regex' do
			valid_addresses = %w[user@example.com User@foo.COM A_US-ER@foo.bar.org
													 first.last@foo.jp alice+bob@baz.cn]
			valid_addresses.each do |valid_address|
				$user.email = valid_address
				expect($user.valid?).to equal (true)
			end
		end
  end

  describe '#does not allow invalid email' do
  	it 'is not valid with improper regex' do
			invalid_addresses = %w[lskolksndg bork@ derp.corp moo,moo,moo 
		 												user.name.@example foo@bar_baz.com foo@bar+dong.mom]
			invalid_addresses.each do |invalid_address|
				$user.email = invalid_address
				expect($user.valid?).to equal (false)
			end
		end
  end

  describe '#email should be unique' do
  	it 'is invalid if duplicate' do
  		dup_user = $user.dup
  		dup_user.email = $user.email.upcase
  		$user.save
  		expect(dup_user.valid?).to equal (false)
  	end
  end
  
	# test "password should be nonempty" do
	# 	@user.password_digest = @user.password_confirmation = " "
	# 	assert_not @user.valid?
	# end

	# test "password should have min length" do
	# 	@user.password_digest = @user.password_confirmation = "a"
	# 	assert_not @user.valid?
	# end 


end
