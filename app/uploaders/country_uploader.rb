class CountryUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production? or Rails.env.staging?
    storage :fog
  else
    storage :file
  end

  process :convert => 'jpg'

  def filename
    if model and model.namespace.present?
      "#{model.namespace}.jpg"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    'countries'
  end

end
