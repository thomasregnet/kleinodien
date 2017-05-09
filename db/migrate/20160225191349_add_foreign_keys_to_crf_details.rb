class AddForeignKeysToCrfDetails < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :crf_details, :cr_formats
  end
end
