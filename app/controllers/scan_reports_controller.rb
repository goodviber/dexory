class ScanReportsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @scan_report = ScanReport.new(scan_report_params)

    if @scan_report.save
      render json: { scan_report_id: @scan_report.id }, status: :created
    else
      render json: { status: 'error', message: 'Failed to upload file', errors: report.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def scan_report_params
    params.require(:scan_report).permit(:json_file)
  end
end
