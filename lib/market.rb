class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def total_inventory
    @vendors.reduce({}) do |vendor_items_and_quantities, vendor|
      vendor.inventory.each do |item, quantity|
        vendor_items_and_quantities[item] = {} if vendor_items_and_quantities[item].nil?
        vendor_items_and_quantities[item][:quantity] = 0 if vendor_items_and_quantities[item][:quantity].nil?
        vendor_items_and_quantities[item][:vendors] = [] if vendor_items_and_quantities[item][:vendors].nil?

        vendor_items_and_quantities[item][:quantity] += quantity
        vendor_items_and_quantities[item][:vendors] << vendor
        vendor_items_and_quantities
      end
      vendor_items_and_quantities
    end
  end

  def overstocked_items
    total_inventory.each_pair do |item, vendor_quantities|
      if total_inventory[item][:vendors].to_a.size > 1 && total_inventory[item][:quantity] > 50
        item
      end
    end
  end

  def sorted_item_list
    item_names = []
    total_inventory.each_key do |item|
      item_names << item.name
    end
    item_names.sort
  end

end
