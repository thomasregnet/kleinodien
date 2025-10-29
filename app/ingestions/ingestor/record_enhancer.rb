module Ingestor
  class RecordEnhancer
    include Callable

    def initialize(kit, persister, record)
      @kit = kit
      @persister = persister
      @record = record
    end

    def call
      delegated_base
    end

    private

    attr_reader :kit, :persister, :record
    delegate_missing_to :kit

    def delegated_base
      base_kit = delegated_base_kit
      return unless base_kit

      delegated_type_attr_name = delegated_of_association.inverse_of.name
      extra_args = {delegated_type_attr_name => record}

      RecordBuilder.call(base_kit, extra_args: extra_args, persister: persister)
    end
  end
end
