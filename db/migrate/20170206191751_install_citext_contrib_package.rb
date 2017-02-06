class InstallCitextContribPackage < ActiveRecord::Migration[5.0]
  def change
    reversible do |citext|
      citext.up do
        execute 'CREATE EXTENSION citext;'
      end
      citext.down do
        execute 'DROP EXTENSION citext;'
      end
    end
  end
end
