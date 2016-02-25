class AddForeignKeysToCrfDetails < ActiveRecord::Migration
  def change
    add_foreign_key :crf_details, :cr_formats
  end
end
