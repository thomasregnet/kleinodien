class IndexJobOnName < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_jobs_on_lower_name
            ON jobs (LOWER(name))
        DDL
      end
      idx.down do
        remove_index :jobs, name: :index_jobs_on_lower_name
      end
    end
  end
end
