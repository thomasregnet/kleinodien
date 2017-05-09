class CreateCompilationReleasesReferences < ActiveRecord::Migration[4.2]
  def change
    create_table :compilation_releases_references, id: false do |t|
      t.references :compilation_release, index: true, foreign_key: true
      t.references :reference, index: true, foreign_key: true
    end
  end
end
