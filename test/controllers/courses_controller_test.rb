require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get new" do
    get new_course_url
    assert_response :success
  end

  test "should create course" do
    assert_difference("Course.count") do
      post courses_url, params: { course: { capacity: @course.capacity, code: @course.code, description: @course.description, end_time: @course.end_time, instructor_id: @course.instructor_id, instructor_name: @course.instructor_name, name: @course.name, room: @course.room, start_time: @course.start_time, status: @course.status, waitlist_capacity: @course.waitlist_capacity, weekday1: @course.weekday1, weekday2: @course.weekday2 } }
    end

    assert_redirected_to course_url(Course.last)
  end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_url(@course)
    assert_response :success
  end

  test "should update course" do
    patch course_url(@course), params: { course: { capacity: @course.capacity, code: @course.code, description: @course.description, end_time: @course.end_time, instructor_id: @course.instructor_id, instructor_name: @course.instructor_name, name: @course.name, room: @course.room, start_time: @course.start_time, status: @course.status, waitlist_capacity: @course.waitlist_capacity, weekday1: @course.weekday1, weekday2: @course.weekday2 } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy course" do
    assert_difference("Course.count", -1) do
      delete course_url(@course)
    end

    assert_redirected_to courses_url
  end
end
