class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :full_name
      t.integer :priority
      t.integer :number_user
      t.timestamps
    end
  end
end
