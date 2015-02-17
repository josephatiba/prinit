class Item
  include Mongoid::Document

  field :variant_id, type: Integer
  field :product_id, type: Integer
  field :quantity, type: Integer
  field :price, type: Float
  field :retail_price, type: Float
  field :name, type: String
  field :size, type: String

  embedded_in :order
end
