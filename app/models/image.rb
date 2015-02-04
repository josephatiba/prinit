class Image
  include Mongoid::Document
  field :url, type: String
  field :name, type: String
  field :private, type: Mongoid::Boolean
end

