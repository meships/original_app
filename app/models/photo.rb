class Photo < ApplicationRecord
  belongs_to :daily_report

  has_many_attached :images
end
