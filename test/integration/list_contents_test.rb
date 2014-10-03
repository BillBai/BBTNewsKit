require 'test_helper'

class ListingContentsTest < ActionDispatch::IntegrationTest
  setup { host! 'api.bbtnewskit.com' }

  fixtures :contents
  test 'returns list of all contents' do

    Content.create!(title: 'Helllo')
    p get '/v1/contents'
    assert_equal 200, response.status
    refute_empty response.body
    p response.body
  end
end
