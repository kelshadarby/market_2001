class Item
  attr_reader :name,
              :price

  def initialize(item_parameters)
    @name = item_parameters[:name]
    @price = item_parameters[:price]
  end
end
