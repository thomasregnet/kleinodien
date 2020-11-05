class AddUriToImportRequests < ActiveRecord::Migration[6.0]
  def up
    add_column :import_requests, :uri, :string

    # ImportRequest.all do |import_request|
    #   import_request.uri = 'https://fake/uri'
    #   import_request.save!
    # end

    execute %q{UPDATE import_requests SET uri = 'https://fake/uri' WHERE uri IS NULL}
    execute 'ALTER TABLE import_requests ALTER COLUMN uri SET NOT NULL'
  end

  def down
    remove_column :import_requests, :uri
  end
end
