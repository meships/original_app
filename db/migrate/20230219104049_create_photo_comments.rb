class CreatePhotoComments < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_comments do |t|
      t.text :comment
      t.references :photo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
