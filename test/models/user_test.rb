require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(username: "Example User", password_digest: "moocows", email: "moogle@doogle.com")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.username = "    "
		assert_not @user.valid?
	end

	test "password should be present" do
		@user.password_digest = "    "
		assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do
		valid_addresses = %w[user@example.com User@foo.COM A_US-ER@foo.bar.org
												 first.last@foo.jp alice+bob@baz.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "email validation should not accept invalid addresses" do
		invalid_addresses = %w[lskolksndg bork@ derp.corp moo,moo,moo 
													user.name.@example foo@bar_baz.com foo@bar+dong.mom]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should not be valid"
		end
	end
end


