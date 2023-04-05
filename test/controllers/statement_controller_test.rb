require "test_helper"

class StatementControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get statement_new_url
    assert_response :success
  end

  test "should get create" do
    get statement_create_url
    assert_response :success
  end
end
