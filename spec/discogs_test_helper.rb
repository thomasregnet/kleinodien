module DiscogsTestHelper
  def self.import_release(name)
    DiscogsImporter.import_release(get_discogs_data('releases', name))
  end

  def self.get_discogs_data(kind, name)
    name = name.to_s + '.json' unless name =~ /\.json$/
    kind = kind.pluralize
    File.open(File.join('fixtures', 'discogs', kind, name)).read
  end
end
