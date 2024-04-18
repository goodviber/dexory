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

    data = parse_scan_report(scan_report.json_file)
    process_csv_file(inventory.csv_file, data)
  end

  private

  def parse_scan_report(scan_report)
    scan_report.open do |file|
      JSON.parse(file.read)
    end
  end

  def process_csv_file(csv_file, data)
    csv_file.open do |file|
      CSV.open('tmp/comparison.csv', 'w', write_headers: true, headers: HEADERS) do |csv|
        CSV.foreach(file, headers: true) do |row|
          data.each do |obj|
            compare_files(row:, obj:, csv:)
          end
        end
      end
    end
  end

  def compare_files(row:, obj:, csv:)
    return unless row['LOCATION'] == obj['name']

    csv << [obj['name'], obj['scanned'], obj['occupied'], row['ITEM'], obj['detected_barcodes'].first,
            location_status(row:, obj:)]
  end

  def location_status(row:, obj:)
    occupied = obj['occupied'] == true
    item = row['ITEM']
    barcode = obj['detected_barcodes'].first

    return 'Occupied but no barcode identified' if occupied && barcode.blank?
    return 'Empty as expected' if item.blank? && barcode.blank? && !occupied
    return 'Empty but expected to be occupied' if item.present? && barcode.blank?
    return 'Occupied as expected' if item == barcode
    return 'Occupied by wrong item' if item != barcode && barcode.present? && item.present?
    return 'Occupied but expected to be empty' if item.blank? && barcode.present? && occupied
    return 'Occupied but no barcode identified' if occupied && barcode.blank?

    'Unknown status'
  end
end
