class Discogs::InsertRelease

  def self.perform(dc_release)
    new(dc_release).perform
  end

  def initialize(dc_release)
    @dc_release = dc_release
  end
  
  def perform
  end  
end
