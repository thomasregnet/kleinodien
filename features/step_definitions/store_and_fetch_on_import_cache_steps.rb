When("I store data to the import cache") do
  @key   = :my_key
  @value = '<my data>'
  ImportCacheStoreService.call(@key, @value)
end

When("I fetch that data from the import cache") do
  @fetched_value = ImportCacheFetchService.call(@key)
end

Then("the data is equal") do
  @value == @fetched_value
end

