require "test_helper"

class MusicBrainzImportOrderTest < ActiveSupport::TestCase
  def test_with_a_valid_uri
    import_order = MusicBrainzImportOrder.new(uri: "https://musicbrainz.org/release/41362dd7-0665-4e09-8158-9ad8109d47bc", user: users(:kim))

    assert_predicate import_order, :valid?
    assert_equal "release", import_order.kind
    assert_equal "41362dd7-0665-4e09-8158-9ad8109d47bc", import_order.code
  end

  def test_with_an_invalid_uri
    import_order = MusicBrainzImportOrder.new(uri: "https://musicbrainz.org/non/sense", user: users(:kim))

    assert_not_predicate import_order, :valid?
    assert_nil import_order.kind
    assert_nil import_order.code
  end
end
