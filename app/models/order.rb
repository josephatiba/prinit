class Order
  include Mongoid::Document
  belongs_to :order_status
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal

  field :subtotal, type: Float
  field :tax, type: Float
  field :shipping, type: Float
  field :total, type: Float
  field :order_date, type: Date
  field :order_status_id, type: Integer
  # field :stripe_id, type: String
  
  belongs_to :user


  def subtotal
    order_items.collect { |oi| oi.valid? ? ((oi.quantity * oi.unit_price) + (oi.quantity * oi.ship_cost)) : 0 }.sum.round(2)
  end

private

  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
