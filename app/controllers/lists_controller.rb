class ListsController < ApplicationController
  def index
    @inventories = Inventory.all
    @scan_reports = ScanReport.all
  end

  def create
    ::CompareFile.new(inventory_id: list_params[:inventory_id], scan_report_id: list_params[:scan_report_id]).call
  end

  private

  def list_params
    params.require(:list).permit(:inventory_id, :scan_report_id)
  end
end
