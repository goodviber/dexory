require 'rails_helper'

RSpec.describe CompareFile do
  describe '#call' do
    let(:inventory) { Inventory.create(csv_file: fixture_file_upload('csv_file.csv', 'text/csv')) }
    let(:scan_report) { ScanReport.create(json_file: fixture_file_upload('json_file.json', 'application/json')) }

    it 'creates a new comparison list' do
      File.delete('tmp/comparison.csv') if File.exist?('tmp/comparison.csv')

      described_class.new(inventory_id: inventory.id, scan_report_id: scan_report.id).call

      expect(File.exist?('tmp/comparison.csv')).to be_truthy
    end

    it 'contains the correct data' do
      file = CSV.parse(File.read('tmp/comparison.csv'), headers: true)
      expect(file.by_col[5]).to eq(['Empty as expected', 'Empty but expected to be occupied', 'Occupied as expected',
                                    'Occupied by wrong item', 'Occupied but expected to be empty', 'Occupied but no barcode identified'])
    end
  end
end
