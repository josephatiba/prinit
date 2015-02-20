class OrderItem
  include Mongoid::Document
  field :unit_price, type: Float
  field :quantity, type: Integer
  field :shipping_cost, type: Float
  # field :seller, type: String
  field :total_price, type: Float
  belongs_to :post
  belongs_to :order
  before_save :finalize
  




  def unit_price
    if persisted?
      self[:unit_price]
    else
      post.price
    end
  end

  def total_price
    (unit_price * quantity) + (quantity * shipping_cost)
  end

  def ship_cost
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
    self[:shipping_cost] = ship_cost
    self[:total_price] = quantity * self[:unit_price]
    # self[:total_price] = self[:total_price] + (self[:shipping_cost] * quantity)
  end


end