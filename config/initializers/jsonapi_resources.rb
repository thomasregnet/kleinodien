JSONAPI.configure do |config|
  # TODO: using underscored_key as json_key_format does not meet the JSON Api
  # TODO: ... naming recommendations, it would be better to let the client
  # TODO: ... sent valid keys
  # http://jsonapi-resources.com/v0.8/guide/formating.html#Key-Format
  #config.json_key_format = :underscored_key
end
