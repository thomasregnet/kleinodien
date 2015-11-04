module AlbumReleasesHelper
  def label_and_catalog_no_for(label)
    return label.company.name unless label.catalog_no
    "#{label.company.name} - #{label.catalog_no}"
  end
end
