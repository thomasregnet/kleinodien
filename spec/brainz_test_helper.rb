module BrainzTestHelper
  def self.get_release(mbid)
    file_name = File.join('fixtures', 'music_brainz', 'release', mbid + '.xml')
    xml = File.open(file_name)
    KleinodienBrainz::Model::Release.xml(xml)
  end
end
