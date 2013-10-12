class ProfileUploader < CarrierWave::Uploader::Base

  if Rails.env.production? or Rails.env.staging?
    storage :fog
  else
    storage :file
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
