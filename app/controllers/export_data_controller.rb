class ExportDataController < ApplicationController
  def index; end

  def execute
    if !params["name_file"].present?
      flash[:notice] = "Your File Name isn't blank"
      redirect_to export_data_path and return
    end
    axlsx = CameoAxlsx.new(User.all, params["name_file"], params["name_sheet"])
    axlsx.execute
    file_xlsx = File.join("#{Rails.root}/public/excel/#{params['name_file']}.xlsx")
    send_file file_xlsx, :disposition => 'inline' rescue ""
  end
end
