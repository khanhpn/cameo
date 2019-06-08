require 'nokogiri'
require 'open-uri'

class CelebvmServices
  def initialize
    @base_url = "https://celebvm.com"
    @logger = Logger.new("#{Rails.root}/log/celebvm_#{Time.zone.now}.log")
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
      category = Category.get_celebvms.find_by(name: raw_item.split("cate=").last)
      next if category.present?
      puts raw_item
      Category.create({type_web: "celebvm", name: raw_item.split("cate=").last})
    end
  end

  private
  def get_links_detail
    Category.get_celebvms.each do |category|
      begin
        doc = Nokogiri::HTML(open("#{@base_url}/search?cate=#{category.name}"))
        raw_links = doc.xpath("//div[@class='img-card text-left']/a[@href]")
        next unless raw_links.present?
        parse_links_detail(raw_links)
      rescue Exception => e
        @logger.debug("#{Time.zone.now} #{e.inspect} #{e.backtrace} #{category.name}")
      end
    end
  end

  def parse_links_detail(raw_links)
    raw_links.each do |detail|
      raw_link_detail = detail.values.dig(0)
      puts raw_link_detail
      @logger.info("#{Time.zone.now} #{raw_link_detail}")
      parse_detail(raw_link_detail)
    end
  end

  def parse_detail(link)
    return unless link.present?
    begin
      doc = Nokogiri::HTML(open("#{@base_url}/#{link}"))
      username = get_name(link)
      price = get_price(doc)
      name = get_username(doc)
      categories = get_categories_name(doc)
      imageUrl = get_image(doc)
      save_to_database({price: price, username: username, name: name, categories: categories, imageUrl: imageUrl, price: price})
    rescue Exception => e
      @logger.debug("#{Time.zone.now} #{e.inspect} #{e.backtrace}")
    end
  end

  def get_name(link)
    link.split("/").last
  end

  def get_username(doc)
    raw_username = doc.xpath("//span[@class='tag d-inline-block']")
    return if !raw_username.present?
    raw_username&.first&.text&.squish
  end

  def get_image(doc)
    raw_img = doc.xpath("//img[@class='img-circle1 img-thumbnail img-fluid mr-2']")
    return if !raw_img.present?
    img = raw_img&.first&.attributes.dig("src")&.value
    "#{@base_url}#{img}"
  end

  def get_price(doc)
    raw_price = doc.xpath("//button[@class='btn btn-danger pr-sm-5']")
    return unless raw_price.present?
    raw_price&.first&.text&.split(" ")&.last&.gsub(/\£|\$/, "")&.to_i
  end

  def get_categories_name(doc)
    raw_category = doc.xpath("//a[@class='btn btn-danger btn-round mr-2 mb-2']")
    return if !raw_category.present?
    raw_category.map(&:text).map(&:squish)
  end

  def save_to_database(args)
    return if !args[:username].present?
    begin
      exist_user = User.get_celebvms.find_by(username: args[:username])
      exist_user.present? ? update_user(exist_user, args)  : create_user(args)
    rescue Exception => e
      @logger.debug("#{Time.zone.now} #{e.inspect} #{e.backtrace}")
    end
  end

  def update_user(exist_user, args)
    exist_user.update({
      name: args[:name],
      username: args[:username],
      imageUrl: args[:imageUrl],
      price: args[:price],
      type_web: "celebvm"
    })
    update_category(exist_user, args)
  end

  def update_category(exist_user, args)
    slugs = args.dig(:categories).map(&:squish)
    categories = exist_user.categories
    items = categories.reject{|item| slugs.include?(item.name)}
    items.map(&:delete) if items.present?
    slugs.each do |slug|
      result = categories.find_by(name: slug)
      next if result.present?
      category = Category.get_celebvms.find_by(name: slug)
      exist_user.tallent_categories.create(category_id: category.id)
    end

  def create_user(args)
    new_user = User.create({
      name: args[:name],
      username: args[:username],
      imageUrl: args[:imageUrl],
      price: args[:price],
      type_web: "celebvm"
    })
    save_category(new_user, args)
  end

  def save_category(new_user, args)
    begin
      categories = args[:categories].map(&:squish)
      return if !categories.present?
      Category.get_celebvms.where(name: categories).each do |cat|
        cat.tallent_categories.create(user_id: new_user.id)
      end
    rescue Exception => e
      @logger.debug("#{Time.zone.now} #{e.inspect} #{e.backtrace}")
    end
  end
end
