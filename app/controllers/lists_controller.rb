class ListsController < ApplicationController
  require 'csv'

  def index
    @inventories = Inventory.all
    @scan_reports = ScanReport.all
  end

  def create
    if ::CompareFile.new(inventory_id: list_params[:inventory_id], scan_report_id: list_params[:scan_report_id]).call
      redirect_to list_path, notice: 'List was successfully created.'
    else
      redirect_to lists_path, alert: 'There was an error creating the list.'
    end
  end

  def show
    file = File.open('tmp/comparison.csv')
    @data = CSV.parse(file, headers: true)
  end

  def download_csv
    if File.exist?('tmp/comparison.csv')
      send_file 'tmp/comparison.csv', type: 'text/csv', disposition: 'attachment'
    else
      redirect_to lists_path, alert: 'There was an error downloading the file.'
    end
  end

  private

  def list_params
    params.require(:list).permit(:inventory_id, :scan_report_id)
  end
end
