class AddAttemptsCountToImportRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :import_requests, :attempts_count, :integer
  end
end
