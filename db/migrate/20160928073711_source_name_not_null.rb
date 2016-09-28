class SourceNameNotNull < ActiveRecord::Migration[5.0]
  def change
    tables = ['compilation_heads', 'compilation_releases',
               'piece_heads',       'piece_releases']
    reversible do |not_null|
      not_null.up do
        tables.each do |table|
          execute <<-DDL.gsub /^\s+/, ''
            ALTER TABLE #{table}
              ALTER COLUMN source_name SET NOT NULL;
          DDL
        end
      end
      not_null.down do
        tables.each do |table|
          execute <<-DDL.gsub /^\s+/, ''
            ALTER TABLE #{table}
              ALTER COLUMN source_name DROP NOT NULL;
          DDL
        end
      end
    end
  end
end
