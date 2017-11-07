# We need to preload all classes of "Import" for Import.const_defined?
# to work proper
Dir[File.dirname(__FILE__) + '/import/*.rb'].each {|file| require file }

# Classes responsible to import data
module Import
  # see also
  # - prepare
  # - persist
end
