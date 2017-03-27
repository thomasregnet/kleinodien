class RailsReleases < ActiveRecord::Migration[5.0]
  def change
    reversible do |brainz|
      brainz.up do
        execute <<-DDL
          CREATE TABLE brainz_releases (
            id bigserial           PRIMARY KEY,
            mbid uuid              NOT NULL,
            url  text              UNIQUE NOT NULL,
            data xml               NOT NULL,
            compilation_release_id integer,
            created_at             timestamp without time zone NOT NULL,
            updated_at             timestamp without time zone NOT NULL,

            FOREIGN KEY (compilation_release_id)
              REFERENCES compilation_releases (id)
         );
        DDL
      end
      brainz.down do
        execute 'DROP TABLE brainz_releases;'
      end
    end
  end
end
