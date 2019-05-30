class ExportDataController < ApplicationController
  def index; end

  def execute
    axlsx = CameoAxlsx.new(User.all, params["name_file"], params["name_sheet"])
    axlsx.execute
    redirect_to export_data_path
  end
end
