require 'test_helper'

class StatisticStarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get statistic_star_index_url
    assert_response :success
  end

end
