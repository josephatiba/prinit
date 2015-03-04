class OrderStatus
  include Mongoid::Document
  has_many :orders
  
  field :name, type: String

end
