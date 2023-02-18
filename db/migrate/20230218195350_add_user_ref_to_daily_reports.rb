class AddUserRefToDailyReports < ActiveRecord::Migration[6.1]
  def change
    add_reference :daily_reports, :user, null: false, foreign_key: true
  end
end
