class Insert::Discogs::Release

  def initialize(dc_release)
    @dc_release = dc_release
  end
  
  def run
    @dc_release
  end
end
