class DropTableJobs < ActiveRecord::Migration[6.0]
  def up
    remove_column :pr_credits, :job_id
    remove_column :ph_credits, :job_id
    drop_table :jobs
  end
end
