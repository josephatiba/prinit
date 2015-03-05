class OrderItem
  include Mongoid::Document
  belongs_to :post
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  # validate :product_present
  # validate :order_present

  field :unit_price, type: Float
  field :quantity, type: Integer
  field :shipping_cost, type: Float
  field :total_price, type: Float
  field :file_url, type: String
  field :variant_id, type: Integer
  accepts_nested_attributes_for :post
  
  before_save :finalize
  


  def unit_price
    self[:unit_price] = 120.00
  end

  #  def unit_price
  #   self[:unit_price] = 111.00
  #   if persisted?
  #     self[:unit_price] = post.price + 111.00
  #   else
      
  #   end
  # end

  def total_price
    (unit_price * quantity) + (quantity * shipping_cost)
  end

  def shipping_cost
    self[:shipping_cost] = 40.13
  end

  private
  def post_present
    if self[:post].nil?
      errors.add(:post, "is not valid or is not active.")
    end
  end

  def order_present
    if self.order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:shipping_cost] = shipping_cost
    self[:total_price] = quantity * self[:unit_price]
    # self[:total_price] = self[:total_price] + (self[:shipping_cost] * quantity)
  end


end