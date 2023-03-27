require "test_helper"
require "shared_bufferable_import_order_tests"
require "shared_import_order_tests"
require "shared_transitionable_tests"

class MusicBrainzImportOrderTest < ActiveSupport::TestCase
  include SharedBufferableImportOrderTests
  include SharedImportOrderTests
  include SharedTransitionableTests

  setup do
    @subject = music_brainz_import_orders(:music_brainz_one)
  end
end
