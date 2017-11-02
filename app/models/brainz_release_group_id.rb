class BrainzReleaseGroupId < BrainzId
  include BrainzCacheKey

  QUERY_STRING = '?inc=artists+url-rels'.freeze

  attr_reader :kind, :query_string

  def initialize(args)
    super(args)
    @kind         = args[:kind] || 'release-group'
    @query_string = args[:query_string] || QUERY_STRING
  end
end
