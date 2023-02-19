class DailyReport < ApplicationRecord
    belongs_to :user

    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings

    has_many :photos, dependent: :destroy
end
