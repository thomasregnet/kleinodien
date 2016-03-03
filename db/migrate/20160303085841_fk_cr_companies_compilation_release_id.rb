class FkCrCompaniesCompilationReleaseId < ActiveRecord::Migration
  def change
    add_foreign_key :cr_companies, :compilation_releases
  end
end
