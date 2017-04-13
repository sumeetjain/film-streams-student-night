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
      user = user.New(name: "  ")
      ## Exercise / Validation
        expect(user.valid?).to equal (false)
      end
  end

	# test "name should be present" do
	# 	@user.name = "    "
	# 	assert_not @user.valid?
	# end

	# test "email validation should accept valid addresses" do
	# 	valid_addresses = %w[user@example.com User@foo.COM A_US-ER@foo.bar.org
	# 											 first.last@foo.jp alice+bob@baz.cn]
	# 	valid_addresses.each do |valid_address|
	# 		@user.email = valid_address
	# 		assert @user.valid?, "#{valid_address.inspect} should be valid"
	# 	end
	# end

	# test "email validation should not accept invalid addresses" do
	# 	invalid_addresses = %w[lskolksndg bork@ derp.corp moo,moo,moo 
	# 												user.name.@example foo@bar_baz.com foo@bar+dong.mom]
	# 	invalid_addresses.each do |invalid_address|
	# 		@user.email = invalid_address
	# 		assert_not @user.valid?, "#{invalid_address.inspect} should not be valid"
	# 	end
	# end

	# test "email address should be unique when submitted" do
	# 	duplicate_user = @user.dup
	# 	duplicate_user.email = @user.email.upcase
	# 	@user.save
	# 	assert_not duplicate_user.valid?
	# end

	# test "password should be nonempty" do
	# 	@user.password_digest = @user.password_confirmation = " "
	# 	assert_not @user.valid?
	# end

	# test "password should have min length" do
	# 	@user.password_digest = @user.password_confirmation = "a"
	# 	assert_not @user.valid?
	# end 


end
