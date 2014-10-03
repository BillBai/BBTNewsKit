require 'test_helper'

class ListingContentsTest < ActionDispatch::IntegrationTest
  setup { host! 'api.bbtnewskit.com' }

  test 'returns list of all contents' do
    p get '/v1/contents'
    assert_equal 200, response.status
    refute_empty response.body
    p response.body
  end

  test 'returns list of sections' do
    p get '/v1/sections'
    assert_equal 200, response.status
    refute_empty response.body
    p response.body
  end
end
