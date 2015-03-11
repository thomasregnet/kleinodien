module DiscogsTestHelper
  def self.get_discogs_release_data(name)
    if ( name !~ /\.json$/ )
      name = name.to_s + '.json'
    end
    file_path = File.join('fixtures', 'discogs', 'releases', name)
    File.open(file_path).read
  end

  def self.import_release(name)
    if ( name !~ /\.json$/ )
      name = name.to_s + '.json'
    end
    file_path = File.join('fixtures', 'discogs', 'releases', name)
    json = File.open(file_path).read
    DiscogsImporter.import_release(json)
  end
end
