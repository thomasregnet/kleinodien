module DiscogsTestHelper
  def self.insert_release(dc_id)
    dc_json = get_discogs_data('releases', dc_id)
    dc_release = KleinodienDiscogs.get_release(dc_json)
    Discogs::InsertRelease.perform(dc_release)
  end

  def self.import_release(name)
    dc_json = get_discogs_data('releases', name)
    dc_release = KleinodienDiscogs.get_release(dc_json)
    Discogs::InsertRelease.perform(dc_release)
  end

  def self.get_discogs_data(kind, name)
    name = name.to_s + '.json' unless name =~ /\.json$/
    kind = kind.pluralize
    File.open(File.join('fixtures', 'discogs', kind, name)).read
  end
end
