module BaseUploader
  class BaseUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    if Rails.env.development? || Rails.env.test?
      storage :file
    else
      storage :fog
    end

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def extension_whitelist
      %w(jpg jpeg gif png)
    end

    def content_type_whitelist
      /image\//
    end

    def size_range
      1..(Settings.carrierwave&.size_upper_limit || 500).kilobytes
    end
  end
end