class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

    if Rails.env.production? || Rails.env.staging?
      storage :fog
    else
      storage :file
    end

    # S3のディレクトリ名
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

      # サムネイルを生成する設定
    version :thumb do
      process :resize_to_fill => [400, 400, gravity = ::Magick::CenterGravity]
    end

    version :thumb100 do
      process :resize_to_fill => [200, 200, gravity = ::Magick::CenterGravity]
    end

    version :thumb30 do
      process :resize_to_fill => [100, 100, gravity = ::Magick::CenterGravity]
    end

    version :square do
      process :resize_to_fill => [100, 100]
    end

    # 許可する画像の拡張子
    def extension_whitelist
       %w(jpg jpeg gif png)
    end

    def size_range
      1..10.megabytes
    end

    # 保存するファイルの命名規則
    def filename
       "#{secure_token}.#{file.extension}" if original_filename.present?
    end

    protected
    # 一意となるトークンを作成
    def secure_token
       var = :"@#{mounted_as}_secure_token"
       model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    end
end
