# frozen_string_litearal: true

require 'sinatra/base'
require 'test_data/path_service'

# Fake API calls to coverartarchive.org
#     FakeCoverart
class FakeCoverart < Sinatra::Base
  # COVERART_FILE_BASE = File.expand_path( '../fixtures/coverartarchive.org', __dir?__).freeze
  get '/:type/:id' do
    content_type :json
    status 200
    json_string = TestData::PathService.call(path: path)
    return json_string if json_string

    status 404
    nil
  end

  get '/:type/:id/:num' do
    content_type :jpg
    status 200
    TestData::PathService.call(path: 'empty.jpg')
  end

  private

  def path
    "coverartarchive.org/#{params[:type]}/#{params[:id]}"
  end
end
