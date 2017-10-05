module KoTestData
  BRAINZ_RELEASE_QUERY_STRING = '_inc_artists_labels_recordings_release-groups'
  def self.brainz_release(brainz_id, query_string = BRAINZ_RELEASE_QUERY_STRING)
    file_name = File.join(
      'fixtures',
      'brainz',
      'release',
      brainz_id + query_string + '.xml'
    )

    File.open(file_name)
  end
end
