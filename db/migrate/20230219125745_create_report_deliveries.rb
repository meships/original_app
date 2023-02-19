class CreateReportDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :report_deliveries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :daily_report, null: false, foreign_key: true

      t.timestamps
    end
  end
end
