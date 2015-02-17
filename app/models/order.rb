class Order
  include Mongoid::Document

  belongs_to :user
  embeds_many :items
end
