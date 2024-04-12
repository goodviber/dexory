class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.string :location
      t.string :item

      t.timestamps
    end
  end
end
