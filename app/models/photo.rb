class Photo < ApplicationRecord
  belongs_to :daily_report

  has_many_attached :images
  has_many :photo_comments, dependent: :destroy

  validates :title,  presence: true, length: { maximum: 30 }
end
