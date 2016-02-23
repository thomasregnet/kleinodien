module Discogs
  # Inserts Labels
  class InsertLabels
    def self.perform(dc_labels, album_release)
      new(dc_labels, album_release).perform
    end

    def initialize(dc_labels, album_release)
      @dc_labels = dc_labels
      @album_release = album_release
    end

    def perform
      labels
    end

    private

    def labels
      @dc_labels.each do |dc_label|
        company = Company.find_or_create_by!(name: dc_label.name)
        @album_release.labels.create!(
          company:    company,
          catalog_no: dc_label.catno
        )
      end
    end
  end
end
