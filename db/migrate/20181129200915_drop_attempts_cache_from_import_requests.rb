class DropAttemptsCacheFromImportRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :import_requests, :attempts_cache, :integer
  end
end
