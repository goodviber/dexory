require 'rails_helper'

RSpec.describe ScanReportsController, type: :controller do
  describe 'POST #create' do
    it 'creates a new scan report' do
      post :create,
           params: { scan_report: { json_file: fixture_file_upload('json_file.json', 'application/json') } }

      expect(response.status).to eq(201)
      expect(ScanReport.count).to eq(1)
      expect(ScanReport.first.json_file.filename).to eq('json_file.json')
    end
  end
end
