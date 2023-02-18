class CreateDailyReports < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_reports do |t|
      t.string :place
      t.date :date
      t.string :address
      t.text :action_content
      t.text :tool
      t.float :latitude
      t.float :longitude
      
      t.timestamps
    end
  end
end
