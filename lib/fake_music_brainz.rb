# frozen_string_literal: true

require 'sinatra/base'
require 'test_data/path_service'

# Fake API calls to musicbrainz.org
class FakeMusicBrainz < Sinatra::Base
  BRAINZ_FILE_BASE = File.expand_path(
    '../fixtures/musicbrainz.org',
    __dir__
  ).freeze

  get '/ws/2/:type/:id' do
    content_type :xml
    status 200
    xml_string = call_path_service
    return xml_string if xml_string

    status 404
    nil
  end

  private

  def relative_path
    "musicbrainz.org/#{params[:type]}/#{params[:id]}#{build_inc}"
  end

  def call_path_service
    TestData::PathService.call(path: relative_path)
  rescue ArgumentError
    nil
  end

  def build_inc
    inc = params[:inc]
    return '' unless inc

    '?inc=' + inc.gsub(/\s+/, '+')
  end
end
