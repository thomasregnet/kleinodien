require 'sinatra/base'

class FakeMusicBrainz < Sinatra::Base
  BRAINZ_FILE_BASE = 'fixtures/musicbrainz.org/'.freeze

  get '/ws/2/:type/:id' do
    xml_response 200, build_path(params)
  end

  private

  def xml_response(response_code, file)
    content_type :xml
    status response_code
    File.open(file).read
  end

  def build_path(params)
    path = BRAINZ_FILE_BASE
    path += "#{params[:type]}/#{params[:id]}"
    path += build_inc(params)
    path + '.xml'
  end

  def build_inc(params)
    return '' unless params[:inc]
    '_inc_' + params[:inc].gsub(/\s+/, '_')
  end
end
