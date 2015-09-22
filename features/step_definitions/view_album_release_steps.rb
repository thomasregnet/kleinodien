require 'discogs_test_helper'

Given(/^The album release with discogs id "(.*?)" exists$/) do |discogs_id|
  @discogs_id = discogs_id
  @release    = DiscogsTestHelper.import_release(@discogs_id)
end
