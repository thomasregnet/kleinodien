class CompilationTrackFormatAbbr < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE compilation_tracks DROP COLUMN format_name;
      ALTER TABLE compilation_tracks DROP COLUMN tr_format_kind_id;

      ALTER TABLE compilation_tracks ADD COLUMN format_abbr text;

      ALTER TABLE compilation_tracks
      ADD CONSTRAINT fk_compilation_tracks_format_abbr
      FOREIGN KEY (format_abbr) REFERENCES formats (abbr);
    DDL
  end
end
