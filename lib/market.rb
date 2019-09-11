class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors.push(vendor)
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    vendors_with_item = []

    @vendors.each do |vendor|
      vendor.inventory.each_key do |product|
        if product == item
          vendors_with_item.push(vendor)
        end
      end
    end

    vendors_with_item
  end

end
