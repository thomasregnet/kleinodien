class CreateCompanyRoles < ActiveRecord::Migration
  def change
    create_table :company_roles do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
