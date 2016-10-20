class AddFormatNameToCompilationTracks < ActiveRecord::Migration[5.0]
  def change
    #add_column :compilation_tracks, :format_name, :text
    reversible do |ct|
      ct.up do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE compilation_tracks
          ADD COLUMN format_name text;

          ALTER TABLE compilation_tracks
          ADD  FOREIGN KEY (format_name)
          REFERENCES ct_formats (name);

          CREATE INDEX index_compilation_tracks_format_name
          ON compilation_tracks (format_name);
        DDL
      end
      ct.down do
        remove_column :compilation_tracks, :format_name
      end
    end
  end
end
