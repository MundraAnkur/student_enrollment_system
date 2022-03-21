require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @course = courses(:one)
  end

  test "visiting the index" do
    visit courses_url
    assert_selector "h1", text: "Courses"
  end

  test "should create course" do
    visit courses_url
    click_on "New course"

    fill_in "Capacity", with: @course.capacity
    fill_in "Code", with: @course.code
    fill_in "Description", with: @course.description
    fill_in "End time", with: @course.end_time
    fill_in "Instructor", with: @course.instructor_id
    fill_in "Instructor name", with: @course.instructor_name
    fill_in "Name", with: @course.name
    fill_in "Room", with: @course.room
    fill_in "Start time", with: @course.start_time
    fill_in "Status", with: @course.status
    fill_in "Waitlist capacity", with: @course.waitlist_capacity
    fill_in "Weekday1", with: @course.weekday1
    fill_in "Weekday2", with: @course.weekday2
    click_on "Create Course"

    assert_text "Course was successfully created"
    click_on "Back"
  end

  test "should update Course" do
    visit course_url(@course)
    click_on "Edit this course", match: :first

    fill_in "Capacity", with: @course.capacity
    fill_in "Code", with: @course.code
    fill_in "Description", with: @course.description
    fill_in "End time", with: @course.end_time
    fill_in "Instructor", with: @course.instructor_id
    fill_in "Instructor name", with: @course.instructor_name
    fill_in "Name", with: @course.name
    fill_in "Room", with: @course.room
    fill_in "Start time", with: @course.start_time
    fill_in "Status", with: @course.status
    fill_in "Waitlist capacity", with: @course.waitlist_capacity
    fill_in "Weekday1", with: @course.weekday1
    fill_in "Weekday2", with: @course.weekday2
    click_on "Update Course"

    assert_text "Course was successfully updated"
    click_on "Back"
  end

  test "should destroy Course" do
    visit course_url(@course)
    click_on "Destroy this course", match: :first

    assert_text "Course was successfully destroyed"
  end
end
