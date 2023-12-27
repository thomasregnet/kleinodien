require "test_helper"

class Import::JsonTest < ActiveSupport::TestCase
  setup do
    json_string = JSON.generate(
      "some-data" => "value",
      "deep" => {"nested" => {"data" => "here"}},
      "a-list" => ["first item", {"a-hash" => {"some" => "value"}}, %w[1 2 3]]
    )

    @parsed = Import::Json.parse(json_string)
  end

  test "#parse returns an OpenStruct" do
    assert_kind_of OpenStruct, @parsed
  end

  test "Dashes are transformed to underscores" do
    assert_equal @parsed.some_data, "value"
  end

  test "deep nested Hash" do
    assert_equal @parsed.deep.nested.data, "here"
    assert_kind_of OpenStruct, @parsed.deep.nested
  end

  test "Array with a String" do
    assert_equal @parsed.a_list.first, "first item"
  end

  test "Array with a Hash" do
    assert_equal @parsed.a_list.second.a_hash.some, "value"
    assert_kind_of OpenStruct, @parsed.a_list.second.a_hash
  end

  test "Array with an Array" do
    assert_equal @parsed.a_list[2], ["1", "2", "3"]
  end
end
