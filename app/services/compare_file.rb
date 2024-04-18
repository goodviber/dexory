require 'csv'

class CompareFile
  HEADERS = ['Location', 'Scanned', 'Occupied', 'Expected Barcodes', 'Actual barcodes', 'Status'].freeze

  def initialize(inventory_id:, scan_report_id:)
    @inventory_id = inventory_id
    @scan_report_id = scan_report_id
  end

  def call
    inventory = Inventory.find(@inventory_id)
    scan_report = ScanReport.find(@scan_report_id)

    scan_report.json_file.open do |json_file|
      @data = JSON.parse(json_file.read)
    end

    inventory.csv_file.open do |csv_file|
      CSV.open('comparison.csv', 'wb', write_headers: true, headers: HEADERS) do |csv|
        CSV.foreach(csv_file, headers: true) do |row|
          @data.each do |obj|
            compare_files(row, obj, csv)
          end
        end
      end
    end
  end

  private

  def compare_files(row, obj, csv)
    return unless row['LOCATION'] == obj['name']

    csv << [obj['name'], obj['scanned'], obj['occupied'], row['ITEM'], obj['detected_barcodes'].first,
            location_status(row, obj)]
  end

  def location_status(row, obj)
    occupied = obj['occupied'] == true
    item = row['ITEM']
    barcode = obj['detected_barcodes'].first

    return 'Empty as expected' if item.blank? && barcode.blank?
    return 'Empty but expected to be occupied' if item.present? && barcode.blank?
    return 'Occupied as expected' if item == barcode
    return 'Occupied by wrong item' if item != barcode
    return 'Occupied but expected to be empty' if item.blank? && barcode.present?
    return 'Occupied but no barcode identified' if occupied && barcode.blank?

    'Unknown status'
  end
end
