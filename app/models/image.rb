class Image
  include Mongoid::Document
  field :url, type: String
  field :name, type: String
  field :private, type: Boolean
  # will have to add field :user_id, type: Integer

  mount_uploader :image, PictureUploader

end

