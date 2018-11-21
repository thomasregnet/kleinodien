# frozen_string_literal: true

require 'sinatra/base'

# Fake API calls to musicbrainz.org
class FakeMusicBrainz < Sinatra::Base
  BRAINZ_FILE_BASE = File.expand_path(
    '../fixtures/musicbrainz.org',
    __dir__
  ).freeze

  get '/ws/2/:type/:id' do
    xml_response build_path
  end

  private

  def xml_response(file)
    content_type :xml

    if File.file?(file)
      status 200
      File.open(file).read
    else
      status 404
    end
  end

  def build_path
    "#{BRAINZ_FILE_BASE}/#{params[:type]}/#{params[:id]}#{build_inc}.xml"
  end

  def build_inc
    inc = params[:inc]
    return '' unless inc

    '?inc=' + inc.gsub(/\s+/, '+')
  end
end
