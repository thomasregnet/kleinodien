# frozen_string_literal: true

BRAINZ_ARTIST_QUERY_STRING = 'inc=artist-rels+url-rels'
BRAINZ_RELEASE_GROUP_QUERY_STRING = \
  'inc=artists+artist-rels+label-rels+url-rels'
BRAINZ_RELEASE_QUERY_STRING = 'inc=artists+labels+recordings+release-groups'

BRAINZ_INC_FOR = {
  artist:        BRAINZ_ARTIST_QUERY_STRING,
  release:       BRAINZ_RELEASE_QUERY_STRING,
  release_group: BRAINZ_RELEASE_GROUP_QUERY_STRING
}.freeze

ACCURACY_MILLISECOND = 'millisecond'
ACCURACY_SECOND      = 'second'
ACCURACY_MINUTE      = 'minute'
ACCURACY_HOUR        = 'hour'

SECOND_MS = 1_000
MINUTE_MS = 60_000
HOUR_MS   = 3_600_000
