class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  
  field :title, type: String
  field :price, type: Float
  field :description, type: String
  field :public, type: Mongoid::Boolean, default: :true
  field :active, type: Mongoid::Boolean, default: :true

  belongs_to :user
  has_many :order_items
  accepts_nested_attributes_for :order_items

  # default_scope { where(active: true) }
 

  mount_uploader :image, PictureUploader

  def date_added
    created_at.localtime.strftime("%-m/%-d/%Y | %l:%M %p")
  end

  
end
