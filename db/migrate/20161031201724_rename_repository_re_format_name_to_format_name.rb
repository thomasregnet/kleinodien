class RenameRepositoryReFormatNameToFormatName < ActiveRecord::Migration[5.0]
  def change
    rename_column :repositories, :re_format_name, :format_name
  end
end
