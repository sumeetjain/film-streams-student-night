require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(username: "Example User", password_digest: "moocows")
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
end


