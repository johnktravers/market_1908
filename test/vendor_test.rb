require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_initialize
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal Hash.new(0), @vendor.inventory
  end

  def test_stock
    @vendor.stock("Peaches", 30)
    expected = {"Peaches" => 30}
    assert_equal expected, @vendor.inventory

    @vendor.stock("Tomatoes", 12)
    expected = {"Peaches" => 30, "Tomatoes" => 12}
    assert_equal expected, @vendor.inventory

    @vendor.stock("Peaches", 25)
    expected = {"Peaches" => 55, "Tomatoes" => 12}
    assert_equal expected, @vendor.inventory
  end

  def test_check_stock
    assert_equal 0, @vendor.check_stock("Peaches")

    @vendor.stock("Peaches", 30)
    assert_equal 30, @vendor.check_stock("Peaches")

    @vendor.stock("Peaches", 25)
    assert_equal 55, @vendor.check_stock("Peaches")
  end

end
