require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "user save" do
   user = User.new({
    "firstName": "John",
    "lastName": "Doe",
    "email": "john@email.com",
    "password": "complex_password",
    "country": "USA"
  })
   assert user.save, 'Failed to save'
  end

  test "user email format vaildate" do
    user = User.new({
     "firstName": "John",
     "lastName": "Doe",
     "email": "not_email.com",
     "password": "complex_password",
     "country": "USA"
   })
    assert !user.save, 'Failed to email format vaildate'
   end

  test "user validate" do
    user = User.new({
      'firstName': "",
      'lastName': "",
      'email': "",
      'password': "",
      'country': ""
    })
    assert !user.save, "Failed to vaildate"
    assert_equal user.errors.size, 5, "Failed to validate count"
  end

  test "user email unique" do
    user_one = User.new({
      "firstName": "John",
      "lastName": "Doe",
      "email": "john@email.com",
      "password": "complex_password",
      "country": "USA"
    })
    user_one.save

    user_two = User.new({
      "firstName": "John",
      "lastName": "Doe",
      "email": "john@email.com",
      "password": "complex_password",
      "country": "USA"
    })
    assert !user_two.save, "Failed to email unique validate"
    assert user_two.errors[:email].any?, "Failed to email unique validate"
  end
end
