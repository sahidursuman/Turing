require 'test_helper'

class StaffTest < ActiveSupport::TestCase
  
  def setup 
    @staff = Staff.new(staff_name: "Lewis Fogden", 
             staff_email: "lewisfogden@bipb.com")
  end
  
  test "staff should be valid" do
    assert @staff.valid?
  end
  
  test "staff_name should be present" do
    @staff.staff_name = " "
    assert_not @staff.valid?
  end
  
  test "staff_name should be < 50" do
    @staff.staff_name = "a" * 51
    assert_not @staff.valid?
  end
  
  test "staff_name should be > 5" do
    @staff.staff_name = "a"
    assert_not @staff.valid?
  end
  
  test "staff_email should be present" do
    @staff.staff_email = " "
    assert_not @staff.valid?
  end
  
  test "staff_email should be < 50" do
    @staff.staff_email = "a" * 51
    assert_not @staff.valid?
  end
  
  test "staff_email should be > 5" do
    @staff.staff_email = "a"
    assert_not @staff.valid?
  end
  
  test "staff_email should be unique" do
    dup_staff = @staff.dup
    dup_staff.staff_email = @staff.staff_email.upcase
    @staff.save
    assert_not dup_staff.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w(user@bipb.com user@bipb.turing.org first.last@bipb.com ha-ho@turing.co.uk)
    valid_addresses.each do |va|
      @staff.staff_email = va
      assert @staff.valid?, "#{va.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w(user@bipb,com user.name@turing. user@tur_ing.com us_er@tu+ring.com)
    invalid_addresses.each do |ia|
      @staff.staff_email = ia
      assert_not @staff.valid?, "#{ia.inspect} should be invalid"
    end
  end
  
end