require 'tag'

class Link
  # Class corresponds to a table in the databse
  # Can use this to maniuplate the data

  # this line makes instances of the link class Datamapper resources
  include DataMapper::Resource

  # This block describes what resources our model will have
  property :id,    Serial # Serial means that it will be auto-incremented for every record
  property :title, String
  property :url,   String

  has n, :tags, :through => Resource

end