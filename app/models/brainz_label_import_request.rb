# frozen_string_literal: true

# ImportRequest for MusicBrainz companys
class BrainzLabelImportRequest < BrainzImportRequest
  QUERY_KIND = 'label'

  def kind
    QUERY_KIND
  end

  def query_string
    ''
  end
end
