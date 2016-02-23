module Discogs
  # creates a Reference to Discgs as DataSupplier
  class InsertReference
    def self.perform(identifier, owner, klass)
      new(identifier, owner, klass).perform
    end

    def initialize(identifier, owner, klass)
      @identifier = identifier
      @owner      = owner
      @klass      = klass
    end

    def perform
      return unless @identifier
      reference
    end

    private

    def reference
      supplier = DataSupplier.find_or_create_by!(name: 'Discogs')
      reference = create_reference(supplier)
      @owner.reference = reference
    end

    def create_reference(supplier)
      @klass.create!(
        identifier: @identifier,
        supplier:   supplier
      )
    end
  end
end
