class CameoServices
  def initialize
    @base_url = "https://www.cameo.com/api/userCategory/show/"
    @logger = Logger.new("#{Rails.root}/log/cameo_#{Time.zone.now}.log")
  end

  def execute
    Category.all.each do |category|
      response = HTTParty.get("#{@base_url}#{category.name}", format: :plain)
      data = JSON.parse(response, symbolize_names: true)
      save_to_database(data, category)
    end
  end

  private
  def save_to_database(data, category)
    users = data[:users]
    return if !users.present? && users.size <= 0
    users.each do |user|
      begin
        user = User.find_by(_id: user.dig(:_id))
        next if user.present?
        Category.find_by(name: category.name).users.create({
          _id: user.dig(:_id),
          name: user.dig(:name),
          username: user.dig(:username),
          engagement_speed: user.dig(:engagement, :speed),
          engagement_volume: user.dig(:engagement, :volume),
          engagement_score: user.dig(:engagement, :score),
          firstOrderCompletedAt: user.dig(:firstOrderCompletedAt),
          averageMillisecondsToComplete: user.dig(:averageMillisecondsToComplete),
          imageUrl: user.dig(:imageUrl),
          imageUrlKey: user.dig(:imageUrlKey),
          numOfRatings: user.dig(:numOfRatings),
          averageRating: user.dig(:averageRating),
          price: user.dig(:price),
          profession: user.dig(:profession),
          bio: user.dig(:bio)
        })
      rescue Exception => e
        @logger.debug("#{Time.zone.now} #{e.inspect} #{e.backtrace}")
      end
    end
  end
end
