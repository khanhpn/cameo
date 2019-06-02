class User < ApplicationRecord
  has_many :tallent_categories
  has_many :categories, through: :tallent_categories

  def self.sort_user(condition)
    users = self.includes(:categories)
    users = users.where("name like ? or username like ?", "%#{condition['keyword']}%", "%#{condition['keyword']}%") if condition['keyword'].present?
    users = users.order(created_at: condition["created_at"]) if condition["created_at"].present?
    return users.order(name: condition["name"]) if condition["name"].present?
    return users.order(numOfRatings: condition["numOfRatings"]) if condition["numOfRatings"].present?
    users
  end
end
