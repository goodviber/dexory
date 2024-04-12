class Inventory < ApplicationRecord
  has_one_attached :csv_file

  validates :location, presence: true
end
