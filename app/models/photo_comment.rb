class PhotoComment < ApplicationRecord
  belongs_to :photo

  validates :comment,  presence: true
end
