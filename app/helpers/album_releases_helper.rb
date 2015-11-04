module AlbumReleasesHelper
  def label_and_catalog_no_for(label)
    return label.company.name unless label.catalog_no
    "#{label.company.name} - #{label.catalog_no}"
  end

  def format_quantity_multiplied_name_for(format)
    return format.kind.name unless format.quantity
    "#{format.quantity} x #{format.kind.name}"
  end
end
