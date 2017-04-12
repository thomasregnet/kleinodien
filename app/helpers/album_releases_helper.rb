# Helpers for AlbumRelease views
module AlbumReleasesHelper
  def label_and_catalog_no_for(label)
    return label.company.name unless label.catalog_no
    "#{label.company.name} - #{label.catalog_no}"
  end

  def format_quantity_multiplied_name_for(format)
    return format.kind.name unless format.quantity
    "#{format.quantity} x #{format.name}"
  end

  def format_details_for(format)
    return unless format.details
    format.details.map(&:name).join(', ')
  end

  def product_number_disambiguation_for(product_number)
    if product_number.disambiguation
      product_number_with_disambiguation(product_number)
    else
      product_number_without_disambiguation(product_number)
    end
  end

  def product_number_with_disambiguation(p_num)
    "#{p_num.type.name} (#{p_num.disambiguation}) #{p_num.code}"
  end

  def product_number_without_disambiguation(product_number)
    "#{product_number.type.name} #{product_number.code}"
  end
end
