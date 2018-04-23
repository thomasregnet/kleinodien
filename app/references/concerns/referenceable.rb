# frozen_string_literal: true

# Configuration methods for references
module Referenceable
  extend ActiveSupport::Concern

  included do
    define_singleton_method(:category) do |category_name|
      define_method(:category) { category_name }
    end

    define_singleton_method(:kind) do |value|
      define_method(:kind) { value }
    end

    define_singleton_method(:scheme) do |schema_name|
      define_method(:scheme) { schema_name.to_s }
    end

    define_singleton_method(:host) do |host_name|
      define_method(:host) { host_name }
    end

    define_singleton_method(:path_prefix) do |path_prefix_name|
      define_method(:path_prefix) { path_prefix_name }
    end

    define_singleton_method(:query_string) do |value|
      define_method(:query_string) { value }
    end
  end
end
