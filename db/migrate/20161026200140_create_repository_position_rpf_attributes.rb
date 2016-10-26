class CreateRepositoryPositionRpfAttributes < ActiveRecord::Migration[5.0]
  def change
    reversible do |attrs|
      attrs.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE TABLE repository_position_rpf_attributes (
            ref_attribute_name text,
            repository_id      integer,
            no                 integer,

            PRIMARY KEY (ref_attribute_name, repository_id, no),

            FOREIGN KEY (ref_attribute_name)
            REFERENCES ref_attributes (name),

            FOREIGN KEY (repository_id)
            REFERENCES repositories (id)
          );
        DDL
      end
      attrs.down do
        drop_table :repository_position_rpf_attributes
      end
    end
  end
end
