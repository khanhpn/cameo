class CameoAxlsx
  attr_accessor :axls, :name, :worksheet, :type
  def initialize(users, name, worksheet, type)
    @users = users
    @axls = Axlsx::Package.new
    @name = name
    @worksheet = worksheet
    @type = type
  end

  def execute
    @axls.workbook.add_worksheet(name: @worksheet) do |sheet|
      sheet.add_row ["Cameo Users"]
      header = @type == "cameo" ? header_cameo : header_celebvm
      sheet.add_row header
      @users.each do |user|
        row = []
        header.each do |label|
          row << user.send(label)
        end
        sheet.add_row row
      end
    end
    export_excel
  end

  def header_cameo
    sheet.add_row header
  end

  def header_celebvm
    sheet.add_row header
  end

  private
  def export_excel
    FileUtils.remove_dir("public/excel") if Dir.exist?('public/excel')
    Dir.mkdir('public/excel')
    @axls.serialize("#{Rails.root}/public/excel/#{@name}.xlsx")
  end

  def header_cameo
    %w(_id name username engagement_speed engagement_volume engagement_score firstOrderCompletedAt averageMillisecondsToComplete imageUrl imageUrlKey numOfRatings averageRating price profession bio)
  end

  def header_celebvm
    %w(name username imageUrl price)
  end
end
