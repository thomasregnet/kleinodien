class ExtractBrainzImportOrderParamsService
  def self.call(uri)
    new(uri).call
  end

  attr_reader :uri

  def initialize(uri)
    @uri = uri
  end

  def call
    code = extract_code || return
    kind = extract_kind || return

    { code: code, kind: kind }
  end

  def extract_code
    path_elements[offset + 1]
  end

  def extract_kind
    path_elements[offset]
  end

  def offset
    return 2 if path_elements.first == 'ws'

    0
  end

  def path_elements
    path = uri.path.split('/')
    path.shift
    path
  end
end
