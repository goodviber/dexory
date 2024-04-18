class Inventory < ApplicationRecord
  has_one_attached :csv_file

  validate :is_csv_file?

  private

  def is_csv_file?
    return if csv_file.attached? && csv_file.content_type == 'text/csv'

    errors.add(:csv_file, 'must be a CSV file')
  end
end
