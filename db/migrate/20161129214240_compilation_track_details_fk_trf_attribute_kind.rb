class CompilationTrackDetailsFkTrfAttributeKind < ActiveRecord::Migration[5.0]
  def change
    reversible do |fk|
      fk.up do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE compilation_track_details
          ADD CONSTRAINT fk_compilation_track_details_track_detail_kind
          FOREIGN KEY (trf_attribute_kind_id)
          REFERENCES track_detail_kinds (id);
        DDL
      end
      fk.down do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE compilation_track_details
          DROP CONSTRAINT fk_compilation_track_details_track_detail_kind;
        DDL
      end
    end
  end
end
