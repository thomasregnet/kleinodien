class BrainzArtistBlueprint < BrainzBaseBlueprint
  def reference
    BrainzArtistReference.from_code(id)
  end
end
