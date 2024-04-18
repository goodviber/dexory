require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  describe 'POST #create' do
    let(:inventory) { Inventory.create(csv_file: fixture_file_upload('csv_file.csv', 'text/csv')) }
    let(:scan_report) { ScanReport.create(json_file: fixture_file_upload('json_file.json', 'application/json')) }
    let(:list_params) { { list: { inventory_id: inventory.id.to_s, scan_report_id: scan_report.id.to_s } } }
    let(:service) { instance_double(CompareFile) }

    before do
      allow(CompareFile).to receive(:new).and_return(service)
      allow(service).to receive(:call).and_return(true)
    end

    it 'calls the CompareFile service' do
      File.delete('tmp/comparison.csv') if File.exist?('tmp/comparison.csv')

      post :create, params: list_params

      expect(CompareFile).to have_received(:new).with(inventory_id: inventory.id.to_s,
                                                      scan_report_id: scan_report.id.to_s)

      expect(service).to have_received(:call)
    end

    it 'redirects to the list path' do
      post :create, params: list_params
      expect(response).to redirect_to(list_path)
    end

    it 'redirects to the lists path if there is an error' do
      allow(service).to receive(:call).and_return(false)
      post :create, params: list_params
      expect(response).to redirect_to(lists_path)
    end
  end
end
