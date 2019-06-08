class ExportDataController < ApplicationController
  def index; end

  def execute
    if !params["name_file"].present?
      flash[:notice] = "Your File Name isn't blank"
      redirect_to export_data_path and return
    end
    if !params["type"].present?
      flash[:notice] = "Please choose type user"
      redirect_to export_data_path and return
    end

    users = params["type"] === "cameo" ? User.get_cameos : User.get_celebvms
    axlsx = CameoAxlsx.new(users, params["name_file"], params["name_sheet"], params["type"])
    axlsx.execute
    file_xlsx = File.join("#{Rails.root}/public/excel/#{params['name_file']}.xlsx")
    send_file file_xlsx, :disposition => 'inline' rescue ""
  end
end
