class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.text :title
      t.references :daily_report, null: false, foreign_key: true

      t.timestamps
    end
  end
end
