class ImportBrainzReleaseService
  include CallWithArgs
  include DataImportTransaction

  private

  attr_reader :code, :importer_name

  def initialize(args)
    @code          = args[:code]
    @importer_name = args[:importer_name]
  end

  def private_call
    data_import_transaction
    false
  end

  def prepare
    PrepareBrainzReleaseService.call(
      importer_name: importer_name,
      reference:     reference
    )
  end

  def persist
    PersistBrainzReleaseService.call(
      importer_name: importer_name,
      reference:     reference
    )
  end

  def reference
    @reference ||= BrainzReleaseReference.from_code(code)
  end
end
