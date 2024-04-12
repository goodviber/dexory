class ScanReport < ApplicationRecord
  has_one_attached :json_file
  
  validates :name, presence: true
end
