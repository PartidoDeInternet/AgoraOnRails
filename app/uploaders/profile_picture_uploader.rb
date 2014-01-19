# encoding: utf-8

class ProfilePictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #Process files as they are uploaded:
  process :resize_to_limit => [300, 300]

  # Create different versions of your uploaded files:
  version :mini do
     process :resize_to_fit => [60, 60]
  end
end
