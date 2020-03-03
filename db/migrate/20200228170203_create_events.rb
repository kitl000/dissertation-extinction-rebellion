class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :image
      t.string :start_time
      t.string :end_time
      t.string :description
      t.string :place_name
      t.float :lat
      t.float :long
      t.string :street
      t.string :zip

      t.timestamps
    end
  end
end
