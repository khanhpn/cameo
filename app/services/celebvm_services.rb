require 'nokogiri'
require 'open-uri'

class CelebvmServices
  def initialize
    @base_url = "https://celebvm.com"
    @details = []
  end

  def execute
    get_categories
    get_links_detail
  end

  def get_categories
    doc = Nokogiri::HTML(open("#{@base_url}/search"))
    raw_categories = doc.xpath("//ul[@class='category-list category-control']/li/a")
    return unless raw_categories.present?
    raw_categories.each do |item|
      raw_item = item&.values.dig(0)
      category = Category.get_celebvms.find_by(name: raw_item.split("cat=").last)
      next if category.present?
      puts raw_item
      Category.create({type_web: "celebvm", name: raw_item.split("cat=").last})
    end
  end

  private
  def get_links_detail
    Category.get_celebvms.each do |category|
      doc = Nokogiri::HTML(open("#{@base_url}/#{category.name}"))
      raw_links = doc.xpath("//div[@class='img-card text-left']/a[@href]")
      next unless raw_links.present?
      parse_links_detail(raw_links)
    end
  end

  def parse_links_detail(raw_links)
    raw_links.each do |detail|
      raw_link_detail = detail.values.dig(0)
      puts raw_link_detail
      parse_detail(raw_link_detail)
    end
  end

  def parse_detail(link)
    return unless link.present?
    doc = Nokogiri::HTML(open("#{@base_url}/#{link}"))
    binding.pry
  end

  def get_username

  end

  def get_image

  end

  def get_price

  end

  def get_categories

  end

  def save_to_database(data, category)
    users = data[:users]
    return if !users.present? && users.size <= 0
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
      imageUrl: user.dig(:imageUrl),
      price: user.dig(:price),
      type_web: "celebvm"
    })
  end

  def create_user(user)
    new_user = User.create({
      name: user.dig(:name),
      username: user.dig(:username),
      imageUrl: user.dig(:imageUrl),
      price: user.dig(:price),
      type_web: "celebvm"
    })
    save_category(new_user, user)
  end

  def save_category(new_user, user)
    begin
      slugs = user.dig(:categories).map {|item| item.dig(:slug).squish}
      return if !slugs.present?
      Category.where(name: slugs).each do |cat|
        cat.tallent_categories.create(user_id: new_user.id)
      end
    rescue Exception => e
      @logger.debug("#{Time.zone.now} #{e.inspect} #{e.backtrace}")
    end
  end
end
