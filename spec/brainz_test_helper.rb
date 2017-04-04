module BrainzTestHelper
  def self.get_release(mbid)
    file_name = File.join('fixtures', 'music_brainz', 'release', mbid + '.xml')
    xml = File.open(file_name)
    KleinodienBrainz::Model::Release.xml(xml)
  end

  def self.get_xml(type, mbid)
    file_name = File.join('fixtures', 'music_brainz', type.to_s, mbid)
    file_name += '.xml'
    File.open(file_name).read
  end

  def self.get_mashed_brainz(type, mbid)
    xml = get_xml(type, mbid)
    multi_xml = MultiXml.parse(xml)
    klass = "MashedBrainz::#{type.to_s.camelize}".constantize
    klass.new(multi_xml['metadata']['release'])
  end
end
