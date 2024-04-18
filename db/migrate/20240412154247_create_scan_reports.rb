class CreateScanReports < ActiveRecord::Migration[7.1]
  def change
    create_table :scan_reports do |t|
      t.timestamps
    end
  end
end
