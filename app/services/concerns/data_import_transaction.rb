module DataImportTransaction
  extend ActiveSupport::Concern

  def data_import_transaction
    DataImport.transaction do
      prepare
      raise ActiveRecord::Rollback, 'data missing' if something_is_missing?
      persist
    end
  end

  def something_is_missing?
    false
  end
end
