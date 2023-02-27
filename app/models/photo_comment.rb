class PhotoComment < ApplicationRecord
  belongs_to :photo

  validates :comment,  presence: true, length: { maximum: 500 }
end
