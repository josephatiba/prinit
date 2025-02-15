# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog
# 
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  



  version :tile do 
    process :resize_to_fit => [nil, 315]
  end

  version :carousel_slide do 
    process :resize_to_fit => [nil, 500]
  end

  version :post_thumbnail do 
    process :resize_to_fill => [200, 200]
  end

  version :profile_pic do 
    process :resize_to_fill => [150, 150]
  end

  # version :post_pic do 
  #   process :resize_to_fit => [nil, 400]
  # end

  version :two_to_three do 
    process :resize_to_fill => [300, 450]
  end

  version :two_to_three_l do 
    process :resize_to_fill => [450, 300]
  end


  # version :three_to_four do 
  #   process :resize_to_fill => [338, 450]
  # end

  # version :four_to_five do 
  #   process :resize_to_fill => [360, 450]
  # end

  # version :one_to_one do 
  #   process :resize_to_fill => [450, 450]
  # end

  # version :two_to_three_l do 
  #   process :resize_to_fill => [nil ,250]
  # end

  # version :three_to_four_l do 
  #   process :resize_to_fill => [nil ,250]
  # end

  # version :four_to_five_l do 
  #   process :resize_to_fill => [nil ,250]
  # end


  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
