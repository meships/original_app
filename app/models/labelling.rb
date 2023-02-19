class Labelling < ApplicationRecord
  belongs_to :daily_report
  belongs_to :label

  #修正案
  #has_many :daily_reports, through: :labellings
end
