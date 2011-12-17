# encoding: utf-8

class IconUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production? or Rails.env.staging?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "icons/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/images/icons/tag_#{version_name}.png"
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end
  
  # Create different versions of your uploaded files:
  version :small do
    process :resize_to_fill => [32, 32]
    process :convert => 'png'
  end
  
  version :medium do
    process :resize_to_fill => [64, 64]
    process :convert => 'png'
  end
  
  version :large do
    process :resize_to_fill => [256, 256]
    process :convert => 'png'
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "original.jpg" if original_filename
  end

end