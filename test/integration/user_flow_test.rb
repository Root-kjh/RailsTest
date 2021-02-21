require "test_helper"

class UserFlowTest < ActionDispatch::IntegrationTest
  test "signup" do
    post "/api/v1/users/signup",
      params: {firstName: "John", lastName: "Doe", email: "john@email.com", password: "complex_password", country: "USA"}
    assert_equal 201, status
    response_body = JSON.parse(@response.body)

    finded_user = User.find_by_email("john@email.com")

    assert_equal response_body['data']['type'], "users"
    assert response_body['data']['attributes']['token'].present?
    assert_equal response_body['data']['attributes']['email'], "john@email.com"
    assert_equal response_body['data']['attributes']['name'], "John Doe"
    assert_equal response_body['data']['attributes']['country'], "USA"
    assert response_body['data']['attributes']['createdAt'].present?
    assert response_body['data']['attributes']['updatedAt'].present?
  end

  test "exist user signup" do
    post "/api/v1/users/signup",
      params: {:firstName => "John", :lastName => "Doe", :email => "john@email.com", :password => "complex_password", :country => "USA"}
    assert_equal 201, status

    assert_raise ActiveRecord::RecordInvalid do
      post "/api/v1/users/signup",
        params: {:firstName => "John", :lastName => "Doe", :email => "john@email.com", :password => "complex_password", :country => "USA"}
      assert_equal 400, status
    end
  end
  
  test "signup request invalid" do
    assert_raise ActiveRecord::RecordInvalid do
      post "/api/v1/users/signup",
        params: {:firstName => "", :lastName => "", :email => "", :password => "", :country => ""}
      assert_equal 400, status
    end
  end

  test "signin" do
    post "/api/v1/auth/signin",
      params: {:auth => {:email => users(:one).email, :password => "test_one" }}
    assert_equal 200, status
    response_body = JSON.parse(@response.body)

    assert_equal response_body['data']['type'], "users"
    assert response_body['data']['attributes']['token'].present?
    assert_equal response_body['data']['attributes']['email'], users(:one).email
    assert_equal response_body['data']['attributes']['name'], "#{users(:one).firstName} #{users(:one).lastName}" 
    assert !response_body['data']['attributes']['country'].present?
    assert response_body['data']['attributes']['createdAt'].present?
    assert response_body['data']['attributes']['updatedAt'].present?
  end

  test "signin request invalid" do
    post "/api/v1/auth/signin",
      params: {:auth => {:email => users(:one).email}}
    assert_equal 404, status
  end
end
