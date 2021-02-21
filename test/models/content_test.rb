require "test_helper"

class ContentTest < ActiveSupport::TestCase
  test "content save" do
    content = Content.new({
      "user_id": users(:one).id,
      "project_id": projects(:one).id,
      "title": "test",
      "body": "test content"
    })
    assert content.save, "Failed to save"
  end

  test "content vaildate" do
    content = Content.new({
      "user_id": users(:one).id,
      "project_id": projects(:one).id,
      "title": "",
      "body": ""
    })
    assert !content.save, "Failed to vaildate"
    assert_equal content.errors.size, 2, "Failed to vaildate count"
  end

  test "content foreign key user" do
    content = Content.new({
      "user_id": -1,
      "project_id": projects(:one).id,
      "title": "test",
      "body": "test content"
    })
    assert !content.save, "Failed to vaildate"
  end

  test "content foreign key project" do
    content = Content.new({
      "user_id": users(:one).id,
      "project_id": -1,
      "title": "test",
      "body": "test content"
    })
    assert !content.save, "Failed to vaildate"
  end
end