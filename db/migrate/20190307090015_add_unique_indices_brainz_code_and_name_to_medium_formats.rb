class AddUniqueIndicesBrainzCodeAndNameToMediumFormats < ActiveRecord::Migration[5.2]
  def change
    reversible do |indices|
      indices.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX medium_formats_brainz_code_index
          ON medium_formats(brainz_code);
          CREATE UNIQUE INDEX medium_formats_name_index
          ON medium_formats(name);
        DDL
      end
      indices.down do
        execute <<-DDL.gsub /^\s+/, ''
          DROP INDEX medium_formats_brainz_code_index;
          DROP INDEX medium_formats_name_index;
        DDL
      end
    end
  end
end
