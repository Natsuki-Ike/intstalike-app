require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_S3_REGION']
    }

    config.fog_directory  = 'instalike-photo'
    config.cache_storage = :fog
    # config.validate_unique_filename = false
    # config.validate_filename_format = false
    # config.validate_remote_net_url_format = false
  end
end
