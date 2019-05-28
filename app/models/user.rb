class User < ApplicationRecord
  has_many :tallent_categories
  has_many :categories, through: :tallent_categories
end
