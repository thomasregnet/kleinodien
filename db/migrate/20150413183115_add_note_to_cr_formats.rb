class AddNoteToCrFormats < ActiveRecord::Migration
  def change
    add_column :cr_formats, :note, :string
  end
end
