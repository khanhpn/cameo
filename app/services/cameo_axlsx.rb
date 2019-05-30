class CameoAxlsx
  attr_accessor :axls, :name, :worksheet
  def initialize(users, name, worksheet)
    @users = users
    @axls = Axlsx::Package.new
    @name = name
    @worksheet = worksheet
  end

  def execute
    @axls.workbook.add_worksheet(name: @worksheet) do |sheet|
      sheet.add_row ["Cameo Users"]
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

  private
  def export_excel
    FileUtils.remove_dir("public/excel") if Dir.exist?('public/excel')
    Dir.mkdir('public/excel')
    @axls.serialize("#{Rails.root}/public/excel/#{@name}.xlsx")
  end

  def header
    %w(_id name username engagement_speed engagement_volume engagement_score firstOrderCompletedAt averageMillisecondsToComplete imageUrl imageUrlKey numOfRatings averageRating price profession bio)
  end
end
