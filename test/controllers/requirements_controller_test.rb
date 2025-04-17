require "test_helper"

class RequirementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get requirements_index_url
    assert_response :success
  end

  test "should get show" do
    get requirements_show_url
    assert_response :success
  end

  test "should get new" do
    get requirements_new_url
    assert_response :success
  end

  test "should get create" do
    get requirements_create_url
    assert_response :success
  end

  test "should get edit" do
    get requirements_edit_url
    assert_response :success
  end

  test "should get update" do
    get requirements_update_url
    assert_response :success
  end

  test "should get destroy" do
    get requirements_destroy_url
    assert_response :success
  end
end
