module ScanReportsHelper
  def scan_report_id_range
    scan_report_ids = ScanReport.pluck(:id)
    scan_report_ids.min..scan_report_ids.max
  end
end
