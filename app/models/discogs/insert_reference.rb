class Discogs::InsertReference
  def self.perform(identifier, owner, klass)
    new(identifier, owner, klass).perform
  end

  def initialize(identifier, owner, klass)
    @identifier = identifier
    @owner      = owner
    @klass      = klass
  end

  def perform
    reference
  end

  private

  def reference
    supplier = DataSupplier.find_or_create_by!(name: 'Discogs')
    reference = @klass.create!(
      identifier: @identifier,
      supplier:   supplier
    )
    @owner.reference = reference
  end
end
