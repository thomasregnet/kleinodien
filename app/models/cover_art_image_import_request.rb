# frozen_string_literal: true

class CoverArtImageImportRequest < CoverArtImportRequest
  validates :uri, presence: { message: "uri can't be blank" }

  before_validation :ensure_code_has_a_value

  alias_attribute :to_uri, :uri

  private

  def ensure_code_has_a_value
    return if self.code

    match = uri.match(%r{coverartarchive.org/.+/([a-f0-9-]+)/})
    self.code = match[1]
  end
end
