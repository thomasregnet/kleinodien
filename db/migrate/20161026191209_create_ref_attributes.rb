class CreateRefAttributes < ActiveRecord::Migration[5.0]
  def change
    reversible do |ref_attributes|
      ref_attributes.up do
        execute <<-DDL.gsub /^s+/, ''
          CREATE TABLE ref_attributes (
            name text PRIMARY KEY,
            FOREIGN KEY (name) REFERENCES formats (name)
          );
        DDL
      end
      ref_attributes.down do
        drop_table :ref_attributes
      end
    end
  end
end
