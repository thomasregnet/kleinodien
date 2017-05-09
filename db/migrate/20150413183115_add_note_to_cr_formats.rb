class AddNoteToCrFormats < ActiveRecord::Migration[4.2]
  def change
    add_column :cr_formats, :note, :string
  end
end
