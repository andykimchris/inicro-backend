module Constants
  IMAGE_FORMATS = [
    'image/png',
    'image/jpg',
    'image/jpeg',
    'image/webp',
    'image/avif',
    'image/gif'
  ].freeze

  HTTPS_URL_REGEX = %r{\Ahttps://\S+\z}

end
