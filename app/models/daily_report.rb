class DailyReport < ApplicationRecord
    belongs_to :user

    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings

    has_many :photos, dependent: :destroy

    #日報閲覧許可
    has_many :report_deliveries, dependent: :destroy

    #バリデーション
    validates :place,  presence: true
    validates :address,  presence: true
    validates :action_content,  presence: true

end
