class PhotoImageUploader < Shrine
  Attacher.validate do
    validate_max_size 5*1024*1024

    validate_extension %w[jpg jpeg png gif]

    validate_mime_type %w[image/jpeg image/png image/gif]
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      small: magick.resize_to_fill!(300, 300),
      medium: magick.resize_to_limit!(600, 600),
      large: magick.resize_to_limit!(1024, 1024)
    }
  end
end
