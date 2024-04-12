class CreateScanReports < ActiveRecord::Migration[7.1]
  def change
    create_table :scan_reports do |t|
      t.string :name
      t.boolean :scanned, null: false, default: true
      t.boolean :occupied, null: false, default: false
      t.string :barcodes, array: true, default: []

      t.timestamps
    end
  end
end
