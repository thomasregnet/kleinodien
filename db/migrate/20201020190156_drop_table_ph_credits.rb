class DropTablePhCredits < ActiveRecord::Migration[6.0]
  def change
    drop_table :ph_credits
  end
end
