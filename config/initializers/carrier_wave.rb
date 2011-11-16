CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAIJ4P4FKYJGEO2D6Q',
    :aws_secret_access_key  => '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',
    :region                 => 'eu-west-1'
  }
  config.fog_directory  = 'joinplato'
end
