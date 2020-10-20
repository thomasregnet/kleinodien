class DropTablePrCredits < ActiveRecord::Migration[6.0]
  def change
    drop_table :pr_credits
  end
end
