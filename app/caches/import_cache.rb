class ImportCache
  include ImportStore
  include RedisCache

  redis import_store
end
