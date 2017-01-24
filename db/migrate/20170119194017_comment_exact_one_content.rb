class CommentExactOneContent < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE comments ADD CONSTRAINT exact_one_content_on_comments CHECK (
        (artist_credit_id       IS NOT NULL)::integer +
        (artist_id              IS NOT NULL)::integer +
        (compilation_head_id    IS NOT NULL)::integer +
        (compilation_release_id IS NOT NULL)::integer +
        (piece_head_id          IS NOT NULL)::integer +
        (piece_release_id       IS NOT NULL)::integer +
        (repository_id          IS NOT NULL)::integer +
        (season_id              IS NOT NULL)::integer +
        (serial_id              IS NOT NULL)::integer +
        (station_id             IS NOT NULL)::integer = 1
      );
    DDL
  end
end
