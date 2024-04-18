class ScanReport < ApplicationRecord
  has_one_attached :json_file

  validate :is_json_file?

  private

  def is_json_file?
    return if json_file.attached? && json_file.content_type == 'application/json'

    errors.add(:json_file, 'must be a JSON file')
  end
end
