require "test_helper"

class ContentFlowTest < ActionDispatch::IntegrationTest

  def setup
    post "/api/v1/auth/signin",
      params: {:auth => {:email => users(:one).email, :password => "test_one" }}
    assert_equal 200, status
    response_body = JSON.parse(@response.body)
    @jwt = response_body['data']['attributes']['token']
    @owner_name = "#{users(:one).firstName} #{users(:one).lastName}"
    @update_data = {
      "title" => "new content",
      "body" => "updated content"
    }
  end

  test "create content" do
    post "/api/v1/projects/#{projects(:one).id}/contents",
      params: {:title => "test", :body => "test content"},
      headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 201, status
    response_body = JSON.parse(@response.body)

    assert_equal response_body['data']['attributes']['projectId'], projects(:one).id
    assert_equal response_body['data']['attributes']['projectOwnerName'], @owner_name
    assert_equal response_body['data']['attributes']['title'], "test"
    assert_equal response_body['data']['attributes']['body'], "test content"
    assert response_body['data']['attributes']['createdAt'].present?
    assert response_body['data']['attributes']['updatedAt'].present?

  end

  test "create content with jo jwt" do
    post "/api/v1/projects/#{projects(:one).id}/contents",
      params: {:title => "test", :body => "test content"}
      assert_equal 401, status
  end

  test "create content request invalid" do
    assert_raise do
      post "/api/v1/projects/#{projects(:one).id}/contents",
        params: {"body" => "test content"},
        headers: {"Authorization" => "Bearer "+@jwt}
      assert_equal 400, status
    end
  end

  test "get contents" do
    get "/api/v1/projects/#{projects(:one).id}/contents"
    assert_equal 200, status
    response_body = JSON.parse(@response.body)

    assert_equal response_body['data'][0]['attributes']['projectId'], projects(:one).id
    assert_equal response_body['data'][0]['attributes']['projectOwnerName'], @owner_name
    assert_equal response_body['data'][0]['attributes']['title'], contents(:one).title
    assert_equal response_body['data'][0]['attributes']['body'], contents(:one).body
    assert response_body['data'][0]['attributes']['createdAt'].present?
    assert response_body['data'][0]['attributes']['updatedAt'].present?
  end

  test "get contents project not found" do
    get "/api/v1/projects/-1/contents"
    assert_equal 400, status
  end

  test "get specific content" do
    get "/api/v1/projects/#{projects(:one).id}/contents/#{contents(:one).id}"
    assert_equal 200, status
    response_body = JSON.parse(@response.body)

    assert_equal response_body['data']['attributes']['projectId'], projects(:one).id
    assert_equal response_body['data']['attributes']['projectOwnerName'], @owner_name
    assert_equal response_body['data']['attributes']['title'], contents(:one).title
    assert_equal response_body['data']['attributes']['body'], contents(:one).body
    assert response_body['data']['attributes']['createdAt'].present?
    assert response_body['data']['attributes']['updatedAt'].present?
  end

  test "get specific content not found" do
    get "/api/v1/projects/#{projects(:one).id}/contents/-1"
    assert_equal 400, status
  end

  test "update content" do
    put "/api/v1/contents/#{contents(:one).id}",
      params: (@update_data),
      headers: {"Authorization" => "Bearer "+@jwt}
      assert_equal 200, status
      response_body = JSON.parse(@response.body)

      assert_equal response_body['data']['attributes']['projectId'], projects(:one).id
      assert_equal response_body['data']['attributes']['projectOwnerName'], @owner_name
      assert_equal response_body['data']['attributes']['title'], @update_data['title']
      assert_equal response_body['data']['attributes']['body'], @update_data['body']
      assert response_body['data']['attributes']['createdAt'].present?
      assert response_body['data']['attributes']['updatedAt'].present?
  end

  test "update content not found" do
    put "/api/v1/contents/-1",
      params: (@update_data),
      headers: {"Authorization" => "Bearer "+@jwt}
      assert_equal 400, status
  end

  test "update content with jo jwt" do
    put "/api/v1/contents/#{contents(:one).id}",
      params: (@update_data)
    assert_equal 401, status
  end

  test "update content request invalid" do
    put "/api/v1/contents/#{contents(:one).id}",
      params: {"body" => "test"},
      headers: {"Authorization" => "Bearer "+@jwt}
      assert_equal 200, status
  end

  test "delete content" do
    delete "/api/v1/contents/#{contents(:one).id}",
    headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 200, status

    assert !Content.find_by_id(contents(:one).id).present?
  end

  test "delete content not found" do
    delete "/api/v1/contents/-1",
    headers: {"Authorization" => "Bearer "+@jwt}
    assert_equal 400, status
  end

  test "delete content with jo jwt" do
    delete "/api/v1/contents/#{contents(:one).id}"
    assert_equal 401, status

    assert Content.find_by_id(contents(:one).id).present?
  end
end
