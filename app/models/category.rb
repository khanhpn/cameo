class Category < ApplicationRecord
  has_many :tallent_categories
  has_many :users, through: :tallent_categories

  def self.search(date_range)
    binding.pry
  end
end
