class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  # the field is title instead of name 
  field :title, type: String
  field :price, type: Float
  field :description, type: String
  field :public, type: Mongoid::Boolean, default: :true
 # the field is public instead of active

  mount_uploader :image, PictureUploader

  def date_added
    created_at.localtime.strftime("%-m/%-d/%Y | %l:%M %p")
  end

  belongs_to :user

end
