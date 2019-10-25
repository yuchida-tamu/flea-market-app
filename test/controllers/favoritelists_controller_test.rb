require 'test_helper'

class FavoritelistsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favoritelists_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favoritelists_destroy_url
    assert_response :success
  end

end
