class Category < ApplicationRecord
  has_many :tallent_categories
  has_many :users, through: :tallent_categories

  scope :get_cameos, -> {where type_web: "cameo"}
  scope :get_celebvms, -> {where type_web: "celebvm"}

  def self.search(start_time, end_time, type_web)
    results = get_cameos if type_web == "cameo"
    results = get_celebvms if type_web == "celebvm"

    results.where("users.created_at >= ? and users.created_at <= ?", start_time, end_time).references(:users)
  end
end
