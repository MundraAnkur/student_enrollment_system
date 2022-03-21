require "../test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get admin_session_path
    sign_in admins(:one)
  end

  test "should get index" do
    get admin_root_path
    assert_response :success
  end

  test "should get instructors" do
    get admin_instructors_path
    assert assigns(:instructors)
    assert_response :success
  end

  test "should get courses" do
    get admin_courses_path
    assert assigns(:courses)
    assert_response :success
  end

  test "should get students" do
    get admin_students_path
    assert assigns(:students)
    assert_response :success
  end

end
