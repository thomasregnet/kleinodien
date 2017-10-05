# Fetch test Data
module KoTestData
  # TODO: beautify this module
  BRAINZ_RELEASE_QUERY_STRING = '?inc='\
                                'artists+labels+recordings+release-groups'\
                                ''.freeze

  def self.brainz_release(
        brainz_id,
        query_string = BRAINZ_RELEASE_QUERY_STRING
      )
    file_name = File.join(
      'fixtures',
      'brainz',
      'release',
      brainz_id + query_string + '.xml'
    )

    File.open(file_name).read
  end
end
