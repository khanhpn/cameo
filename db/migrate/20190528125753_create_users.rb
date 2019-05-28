class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :_id, index: true
      t.string :name
      t.string :username
      t.float :engagement_speed
      t.float :engagement_volume
      t.float :engagement_score
      t.text :firstOrderCompletedAt
      t.float :averageMillisecondsToComplete
      t.text :imageUrl
      t.text :imageUrlKey
      t.integer :numOfRatings
      t.float :averageRating
      t.float :price
      t.text :profession
      t.text :bio
      t.timestamps
    end
  end
end
