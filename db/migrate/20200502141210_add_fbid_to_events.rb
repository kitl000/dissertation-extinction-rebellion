class AddFbidToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :fbid, :bigint
  end
end
