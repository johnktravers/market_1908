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

  def sorted_item_list
    list = []
    @vendors.each do |vendor|
      list += vendor.inventory.keys
    end

    list.uniq.sort
  end

  def total_inventory
    market_inventory = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |product, quantity|
        market_inventory[product] += quantity
      end
    end

    market_inventory
  end

  def sell(item, quantity)
    if !total_inventory.keys.include?(item) || quantity > total_inventory[item]
      return false
    end

    remainder = quantity
    vendors_that_sell(item).each do |vendor|
      break if remainder == 0

      if remainder <= vendor.inventory[item]
        vendor.inventory[item] -= remainder
        remainder = 0
      else
        remainder -= vendor.inventory[item]
        vendor.inventory[item] = 0
      end
    end

    true
  end
end
