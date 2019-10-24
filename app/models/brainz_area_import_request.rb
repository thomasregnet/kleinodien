# frozen_string_literal: true

# ImportRequest to get an Area from MusicBrainz
class BrainzAreaImportRequest < BrainzImportRequest
  QUERY_KIND = 'area'

  def kind
    QUERY_KIND
  end

  def query_string
    BRAINZ_AREA_QUERY_STRING
  end
end
