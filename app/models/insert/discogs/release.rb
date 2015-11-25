class Insert::Discogs::Release

  def initialize(json)
    @discogs = KleinodienDiscogs.get_release(json)
  end
  
  def run
    @discogs
  end
end
