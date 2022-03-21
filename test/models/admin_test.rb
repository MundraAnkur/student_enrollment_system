require "../test_helper"

class AdminTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "should not save new admin without any information" do
    admin = admins(:one)
    admin.email = nil
    admin.phone = nil
    admin.encrypted_password = nil
    assert_not admin.save
  end

  test "should not save admin without email" do
    admin1 = admins(:one)
    admin1.email = nil
    assert_not admin1.save
  end

  test "should not save admin without phone" do
    admin1 = admins(:one)
    admin1.phone = nil
    assert_not admin1.save
  end

  test "unable to give bad format for email " do
    admin1 = admins(:one)
    admin1.email = "admin1"
    assert_not admin1.save
  end

end
