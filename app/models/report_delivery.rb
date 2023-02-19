class ReportDelivery < ApplicationRecord
  belongs_to :user
  belongs_to :daily_report
end
