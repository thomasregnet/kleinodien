module Discogs
  # Inserts Companies from Discogs
  class InsertCompanies
    def self.perform(dc_companies, album_release)
      new(dc_companies, album_release).perform
    end

    def initialize(dc_companies, album_release)
      @dc_companies  = dc_companies
      @album_release = album_release
    end

    def perform
      companies
    end

    private

    def companies
      @dc_companies.each do |dc_company|
        @dc_company = dc_company
        Discogs::InsertCompany.perform(dc_company, @album_release)
      end
    end
  end
end
