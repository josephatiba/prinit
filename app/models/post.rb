class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :public, type: Mongoid::Boolean, default: :true

  mount_uploader :image, PictureUploader

  def date_added
    created_at.localtime.strftime("%-m/%-d/%Y | %l:%M %p")
  end

  belongs_to :user

end
