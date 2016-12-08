class UniqueIndicesFormatNameAndFormatDetailName < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      CREATE UNIQUE INDEX ON formats (lower(name));
      CREATE UNIQUE INDEX ON format_details (lower(name));
    DDL
  end
end
