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
    "tags"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/images/icons/tag_#{version_name}.png"
  end

  version :small do
    process :resize_to_fill => [32, 32]
    process :convert => 'png'
    def full_filename for_file = model.icon.file
      if model and model.namespace.present?
        "v2-#{model.namespace}_32.png"
      end
    end
  end

  version :medium do
    process :resize_to_fill => [64, 64]
    process :convert => 'png'
    def full_filename for_file = model.icon.file
      if model and model.namespace.present?
        "v2-#{model.namespace}_64.png"
      end
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if model and model.namespace.present?
      "v2-#{model.namespace}_original.png"
    end
  end

end
