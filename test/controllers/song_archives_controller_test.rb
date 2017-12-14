require 'test_helper'

class SongArchivesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get song_archives_index_url
    assert_response :success
  end

end
