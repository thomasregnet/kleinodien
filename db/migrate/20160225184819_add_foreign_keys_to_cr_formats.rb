class AddForeignKeysToCrFormats < ActiveRecord::Migration
  def change
    add_foreign_key :cr_formats, :compilation_releases
    add_foreign_key :cr_formats, :cr_format_kinds
  end
end
