require "application_system_test_case"

class EnrollsTest < ApplicationSystemTestCase
  setup do
    @enroll = enrolls(:one)
  end

  test "visiting the index" do
    visit enrolls_url
    assert_selector "h1", text: "Enrolls"
  end

  test "should create enroll" do
    visit enrolls_url
    click_on "New enroll"

    click_on "Create Enroll"

    assert_text "Enroll was successfully created"
    click_on "Back"
  end

  test "should update Enroll" do
    visit enroll_url(@enroll)
    click_on "Edit this enroll", match: :first

    click_on "Update Enroll"

    assert_text "Enroll was successfully updated"
    click_on "Back"
  end

  test "should destroy Enroll" do
    visit enroll_url(@enroll)
    click_on "Destroy this enroll", match: :first

    assert_text "Enroll was successfully destroyed"
  end
end
