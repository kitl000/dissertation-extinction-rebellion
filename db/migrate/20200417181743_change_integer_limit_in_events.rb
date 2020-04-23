class ChangeIntegerLimitInEvents < ActiveRecord::Migration[5.2]
  def change

    change_column :events, :lat, :integer, limit: 8
    change_column :events, :long, :integer, limit: 8

  end
end
