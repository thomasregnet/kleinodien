require "test_helper"

class Import::BufferTest < ActiveSupport::TestCase
  setup do
    @buffer = Import::Buffer.new
  end

  test "#buffered?" do
    assert_not @buffer.buffered?(:aphrodites_child, 666)

    @buffer.fetch(:aphrodites_child, 666) { "Irene Papas" }

    assert @buffer.buffered?("aphrodites_child", "666")
    assert @buffer.buffered?("aphrodites_child", 666)
  end

  test "#deep_dup" do
    assert_empty @buffer.deep_dup

    @buffer.fetch("foo", :bar) { :baz }

    assert_not_empty @buffer.deep_dup
  end

  test "#fetch" do
    assert_nil @buffer.fetch(:foo, "bar")
    assert_equal @buffer.fetch("foo", :bar) { :baz }, :baz
    assert_equal @buffer.fetch("foo", :bar), :baz
  end

  test "#buffered? with wrong arguments" do
    assert_raises(ArgumentError) { @buffer.buffered?(:foo) }
    assert_raises(ArgumentError) { @buffer.buffered?(:foo, :bar, :baz) }
  end

  test "#fetch with wrong arguments" do
    assert_raises(ArgumentError) { @buffer.fetch(:foo) }
    assert_raises(ArgumentError) { @buffer.fetch(:foo, :bar, :baz) }
    assert_raises(ArgumentError) { @buffer.fetch(:foo, :bar, :baz) { :blubber } }
  end

  test "read from a frozen buffer" do
    @buffer.fetch(:a, :nice) { :value }
    @buffer.freeze

    assert @buffer.frozen?
    assert @buffer.buffered?(:a, "nice")
    assert_equal @buffer.fetch("a", "nice"), :value
  end

  test "write to a frozen buffer" do
    @buffer.freeze
    assert_raises(RuntimeError) { @buffer.fetch(:foo, :bar) { :baz } }
  end
end
