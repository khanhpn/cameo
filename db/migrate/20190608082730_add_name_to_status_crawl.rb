class AddNameToStatusCrawl < ActiveRecord::Migration[5.2]
  def change
    add_column :status_crawls, :name, :string
  end
end
