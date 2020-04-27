class AddCategoryToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :category, :string
    update "UPDATE events SET category = CASE WHEN title LIKE '%Talk%' THEN 'Talk' WHEN title LIKE '%Meeting%' THEN 'Meeting' WHEN title LIKE '%March%' THEN 'March' WHEN title LIKE '%Workshop%' THEN 'Workshop' ELSE 'Other' END"
  end
end
