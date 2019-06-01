class User < ApplicationRecord
  has_many :tallent_categories
  has_many :categories, through: :tallent_categories

  def self.search(condition)
    return order(created_at: condition["created_at"]) if condition["created_at"].present?
    return order(name: condition["name"]) if condition["name"].present?
    return order(numOfRatings: condition["numOfRatings"]) if condition["numOfRatings"].present?
  end
end
