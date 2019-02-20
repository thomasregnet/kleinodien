class DropTableCrCredits < ActiveRecord::Migration[5.2]
  def change
    drop_table :cr_credits
  end
end
