class BrainzArtistBlueprint < BrainzBaseBlueprint
  def reference
    BrainzArtistReferenceBlueprint.from_code(id)
  end
end
