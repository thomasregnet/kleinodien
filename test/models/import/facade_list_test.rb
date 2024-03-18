require "test_helper"
require "minitest/mock"
# require "support/web_mock_external_apis"

class Import::TestFacade
  def initialize(*)
  end
end

class Import::FacadeListTest < ActiveSupport::TestCase
  setup do
    @session = Minitest::Mock.new

    @facade_0 = Import::TestFacade.new
    @session.expect :build_facade, @facade_0 do |consecutive_number: 1, data: :@facade_0, model: Import::TestFacade|
      true
    end

    @facade_1 = Import::TestFacade.new
    @session.expect :build_facade, @facade_1 do |consecutive_number: 2, data: :facede_1, model: Import::TestFacade|
      true
    end

    data = [:@facade_0, :@facade_1]
    @facade_list = Import::FacadeList.new(@session, data: data, model: Import::TestFacade)
  end

  test "#each" do
    enumerator = @facade_list.each
    assert_instance_of Import::TestFacade, enumerator.next
    assert_instance_of Import::TestFacade, enumerator.next

    @session.verify
  end

  test "#map" do
    classes = @facade_list.map { |item| item.class }
    assert_equal classes.length, 2
    assert_equal classes.count { |klass| klass == Import::TestFacade }, 2

    @session.verify
  end

  test "#to_collectors" do
    @session.expect :build_collector, :collector_0, [@facade_0]
    @session.expect :build_collector, :collector_1, [@facade_1]

    collectors = @facade_list.to_collectors

    assert_equal collectors, [:collector_0, :collector_1]

    @session.verify
  end

  test "#to_persisters" do
    @session.expect :build_persister, :persister_0, [@facade_0]
    @session.expect :build_persister, :persister_1, [@facade_1]

    persisters = @facade_list.to_persisters

    assert_equal persisters.length, 2
    assert_equal persisters, [:persister_0, :persister_1]

    @session.verify
  end
end
