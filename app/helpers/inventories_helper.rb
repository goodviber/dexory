module InventoriesHelper
  def inventory_id_range
    inventory_ids = Inventory.pluck(:id)
    inventory_ids.min..inventory_ids.max
  end
end
