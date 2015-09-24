class CompilationReleasesCountry < ActiveRecord::Base
  belongs_to :compilation_release, inverse_of: :compilation_releases_countries
  belongs_to :country, inverse_of: :compilation_releases_countries
end
