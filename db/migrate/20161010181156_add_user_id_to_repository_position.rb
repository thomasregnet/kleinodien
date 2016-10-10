class AddUserIdToRepositoryPosition < ActiveRecord::Migration[5.0]
  def change
    reversible do |user|
      user.up do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE repository_positions
            ADD COLUMN repository_id integer;

          ALTER TABLE repository_positions
            ADD COLUMN user_id integer;

          ALTER TABLE repository_positions
            ADD CONSTRAINT fk_repository_position_user
              FOREIGN KEY (user_id) REFERENCES users (id);

          -- we need an unique index on "repositories" to reference it
          CREATE UNIQUE INDEX index_repositories_id_and_user_id
            ON repositories (id, user_id);

          ALTER TABLE repository_positions
            ADD CONSTRAINT fk_repository_position_repository
              FOREIGN KEY (repository_id, user_id)
                REFERENCES repositories (id, user_id);
        DDL
      end
      user.down do
        execute <<-DDL.gsub /^\s+/, ''
          DROP INDEX fk_repository_position_user;

          ALTER TABLE repository_positions
            DROP COLUMN repository_id;

          ALTER TABLE repository_positions
            DROP COLUMN user_id;
        DDL
      end
    end
  end
end
