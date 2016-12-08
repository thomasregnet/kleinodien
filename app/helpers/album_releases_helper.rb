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
    format.details.map { |detail| detail.name }.join(', ')
  end

  def identifier_disambiguation_for(identifier)
    if identifier.disambiguation
      identifier_with_disambiguation(identifier)
    else
      identifier_without_disambiguation(identifier)
    end
  end

  def identifier_with_disambiguation(identifier)
    "#{identifier.type.name} (#{identifier.disambiguation}) #{identifier.code}"
  end

  def identifier_without_disambiguation(identifier)
    "#{identifier.type.name} #{identifier.code}"
  end
end
