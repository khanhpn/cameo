class AddTypeToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :type_web, :string, index: true
    add_column :users, :type_web, :string, index: true
  end
end
