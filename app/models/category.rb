class Category < ApplicationRecord
  has_many :tallent_categories
  has_many :users, through: :tallent_categories

  def self.search(start_time, end_time)
    where("users.created_at >= ? and users.created_at <= ?", start_time, end_time).references(:users)
  end
end
