class GetImportStoreService
  include ImportStore

  def self.call
    import_store
  end
end
