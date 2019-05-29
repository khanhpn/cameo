class CreateStatusCrawls < ActiveRecord::Migration[5.2]
  def change
    create_table :status_crawls do |t|
      t.string :current_status, default: "new"
      t.timestamps
    end
  end
end
