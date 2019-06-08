class CameoServices
  def initialize
    @base_url = "https://www.cameo.com/api/userCategory/show/"
    @logger = Logger.new("#{Rails.root}/log/cameo_#{Time.zone.now}.log")
  end

  def execute
    @logger.debug("#{Time.zone.now} start crawl data")
    Category.get_cameos.all.each do |category|
      @logger.debug("#{Time.zone.now} starting crawl category #{@base_url}#{category.name}")
      response = HTTParty.get("#{@base_url}#{category.name}", format: :plain)
      data = JSON.parse(response, symbolize_names: true)
      save_to_database(data, category)
    end
    @logger.debug("#{Time.zone.now} finished crawl data")
  end

  private
  def save_to_database(data, category)
    return if data[:status] === 404
    users = data[:users]
    begin
      return if !users.present? && users.try(:size) <= 0
    rescue Exception => e
    end
    users.each do |user|
      begin
        exist_user = User.find_by(_id: user.dig(:_id))
        exist_user.present? ? update_user(exist_user, user)  : create_user(user)
      rescue Exception => e
        @logger.debug("#{Time.zone.now} #{e.inspect} #{e.backtrace}")
      end
    end
  end

  def update_user(exist_user, user)
    exist_user.update({
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
      temporarilyUnavailable: user.dig(:temporarilyUnavailable),
      profession: user.dig(:profession),
      bio: user.dig(:bio),
      type_web: "cameo"
    })
    update_category(exist_user, user)
  end

  def create_user(user)
    new_user = User.create({
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
      temporarilyUnavailable: user.dig(:temporarilyUnavailable),
      price: user.dig(:price),
      profession: user.dig(:profession),
      bio: user.dig(:bio),
      type_web: "cameo"
    })
    save_category(new_user, user)
  end

  def update_category(exist_user, user)
    slugs = user.dig(:categories).map {|item| item.dig(:slug).squish}
    categories = exist_user.categories
    items = categories.reject{|item| slugs.include?(item.name)}
    items.map(&:delete) if items.present?
    slugs.each do |slug|
      result = categories.find_by(name: slug)
      next if result.present?
      category = Category.get_cameos.find_by(name: slug)
      category = Category.create({name: slug, type_web: "cameo"}) unless category.present?
      exist_user.tallent_categories.create(category_id: category.id)
    end
  end

  def save_category(new_user, user)
    begin
      slugs = user.dig(:categories).map {|item| item.dig(:slug).squish}
      return if !slugs.present?
      Category.get_cameos.where(name: slugs).each do |cat|
        cat.tallent_categories.create(user_id: new_user.id)
      end
    rescue Exception => e
      @logger.debug("#{Time.zone.now} #{e.inspect} #{e.backtrace}")
    end
  end
end
