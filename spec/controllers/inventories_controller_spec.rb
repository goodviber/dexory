require 'rails_helper'

RSpec.describe InventoriesController, type: :controller do
  describe 'POST #create' do
    it 'creates a new inventory' do
      post :create,
           params: { inventory: { csv_file: fixture_file_upload('csv_file.csv', 'text/csv') } }

      expect(response.status).to eq(302)
      expect(Inventory.count).to eq(1)
      expect(Inventory.first.csv_file.filename).to eq('csv_file.csv')
    end
  end
end
