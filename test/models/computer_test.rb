require 'test_helper'

class ComputerTest < ActiveSupport::TestCase
  
  def setup
    @staff = Staff.create(staff_name: "John Example", staff_email: "John@example.com")
    @computer = @staff.computers.build(manufacturer: "Toshiba", computer_type: "Laptop",
                model_no: "TSH1137", serial_no: "1234567890",
                donor: "Mr. J. Smith", specification: "Windows XP",
                product_key: "WIN2015123456", turingtrack: "0000000001")
  end
  
  test "computer should be valid" do
    assert @computer.valid?
  end
  
  test "staff_id should be present" do
    @computer.staff_id = nil
    assert_not @computer.valid?
  end

  test "manufacturer should be > 2" do
    @computer.manufacturer = "a"
    assert_not @computer.valid?
  end
  
  test "manufacturer should be < 50" do
    @computer.manufacturer = "a" * 51
    assert_not @computer.valid?
  end

  test "computer_type should be present" do
    @computer.computer_type = " "
    assert_not @computer.valid?
  end
  
  test "computer_type should be > 2" do
    @computer.computer_type = "a"
    assert_not @computer.valid?
  end
  
  test "computer_type should be < 50" do
    @computer.computer_type = "a" * 51
    assert_not @computer.valid?
  end
  
  test "model_no should be > 2" do
    @computer.model_no = "a"
    assert_not @computer.valid?
  end
  
  test "model_no should be < 50" do
    @computer.model_no = "a" * 51
    assert_not @computer.valid?
  end
  
   test "serial_no should be present" do
    @computer.serial_no = " "
    assert_not @computer.valid?
  end
  
  test "serial_no should be > 2" do
    @computer.serial_no = "a"
    assert_not @computer.valid?
  end
  
  test "serial_no should be < 50" do
    @computer.serial_no = "a" * 51
    assert_not @computer.valid?
  end
  
  test "donor should be > 2" do
    @computer.donor = "a"
    assert_not @computer.valid?
  end
  
  test "donor should be < 50" do
    @computer.donor = "a" * 51
    assert_not @computer.valid?
  end
  
  test "specification should be > 2" do
    @computer.specification = "a"
    assert_not @computer.valid?
  end
  
  test "specification should be < 50" do
    @computer.specification = "a" * 251
    assert_not @computer.valid?
  end
  
  test "product_key should be > 2" do
    @computer.product_key = "a"
    assert_not @computer.valid?
  end
  
  test "product_key should be < 50" do
    @computer.product_key = "a" * 51
    assert_not @computer.valid?
  end
  
  test "turingtrack should be < 9" do
    @computer.turingtrack = "a" * 9
    assert_not @computer.valid?
  end
  
  test "turingtrack should be > 7" do
    @computer.turingtrack = "a"
    assert_not @computer.valid?
  end
  
end
