# frozen_string_literal: true

# ImportRequest for a MusicBrainz recording
class BrainzRecordingImportRequest < ImportRequest
  QUERY_KIND = 'recording'

  def kind
    QUERY_KIND
  end

  def query_string
    BRAINZ_RECORDING_QUERY_STRING
  end
end
