class CreateTallentCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :tallent_categories do |t|
      t.belongs_to :category, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
