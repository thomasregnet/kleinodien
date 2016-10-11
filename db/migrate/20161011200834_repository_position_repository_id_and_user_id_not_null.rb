class RepositoryPositionRepositoryIdAndUserIdNotNull < ActiveRecord::Migration[5.0]
  def change
    columns = ['user_id', 'repository_id']
    reversible do |not_null|
      not_null.up do
        columns.each do |column|
          execute <<-DDL.gsub /^\s+/, ''
            ALTER TABLE repository_positions
            ALTER COLUMN #{column} SET NOT NULL;
          DDL
        end
      end
      not_null.down do
        columns.each do |column|
          execute <<-DDL.gsub /^\s+/, ''
            ALTER TABLE repository_positions
            ALTER COLUMN #{column} DROP NOT NULL;
          DDL
        end
      end
    end
  end
end
