require "test_helper"
require "support/shared_import_properties_tests"

class Import::ArtistCreditPropertiesTest < ActiveSupport::TestCase
  include SharedImportPropertiesTests

  setup do
    @subject = Import::ArtistCreditProperties.new
  end

  test "#belongs_to_associations" do
    assert_empty @subject.belongs_to_associations
  end

  test "#has_many_associations" do
    assert_equal @subject.has_many_associations.map(&:name), [:participants]
  end

  test "#has_and_belongs_to_many_associations" do
    assert_empty @subject.has_and_belongs_to_many_associations
  end
end
