class CreateJobs < ActiveRecord::Migration[4.2]
  def change
    create_table :jobs do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
