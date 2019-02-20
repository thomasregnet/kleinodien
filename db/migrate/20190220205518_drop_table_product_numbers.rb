class DropTableProductNumbers < ActiveRecord::Migration[5.2]
  def change
    drop_table :product_numbers
    drop_table :product_number_types
  end
end
