class CreateEventedits < ActiveRecord::Migration[5.2]
  def change
    create_table :eventedits do |t|
      t.string :title
      t.string :image
      t.string :start_time
      t.string :end_time
      t.string :description
      t.bigint :lat
      t.bigint :long
      t.string :street
      t.string :zip
      t.string :city
      t.string :category
      t.bigint :fbid

      t.timestamps
    end
  end
end
