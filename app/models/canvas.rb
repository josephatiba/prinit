class Canvas
  include Mongoid::Document

  field :variant_id, type: Integer
  field :product_id, type: Integer
  field :quantity, type: Integer
  field :price, type: Float
  field :retail_price, type: Float
  field :name, type: String
  field :size, type: String

  belongs_to :post

  def product_id
    3
  end

  def variant_id
    
  end

end
