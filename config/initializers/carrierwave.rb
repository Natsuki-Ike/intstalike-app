unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIASQ6OS7QUWUEHXLG4',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'instalike-photo'
    config.cache_storage = :fog
  end
end
