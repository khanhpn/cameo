require 'test_helper'

class ExportDataControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get export_data_index_url
    assert_response :success
  end

end
