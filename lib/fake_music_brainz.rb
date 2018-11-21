require 'sinatra/base'

# Fake API calls to musicbrainz.org
class FakeMusicBrainz < Sinatra::Base
  BRAINZ_FILE_BASE = File.expand_path(
    '../../fixtures/musicbrainz.org/',
    __FILE__
  ).freeze

  get '/ws/2/:type/:id' do
    xml_response 200, build_path(params)
  end

  private

  def xml_response(response_code, file)
    content_type :xml
    status response_code
    if File.file?(file)
      status response_code
      File.open(file).read
    else
      status 404
    end
  end

  def build_path(params)
    path = BRAINZ_FILE_BASE
    path += "/#{params[:type]}/#{params[:id]}"
    path += build_inc(params)
    path += '.xml'
  end

  def build_inc(params)
    return '' unless params[:inc]
    '?inc='+ params[:inc].gsub(/\s+/, '+')
  end
end
