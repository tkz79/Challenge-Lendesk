require 'exifr/jpeg'

# This class handles extracting EXIF data from images and providing data for
# output files.
class Image

  # Sets gps coordinates to nil if EXIF data is missing
  #
  #   image_path: a string path to the image
  def initialize(image_path)
    @directory, @file_name = File.split(image_path)
    begin
      image_exif = EXIFR::JPEG.new(image_path)
      @latitude = image_exif.gps.latitude
      @longitude = image_exif.gps.longitude
    rescue NoMethodError
      @latitude = nil
      @longitude = nil
    end
  end

  # Returns instance variables as an array
  def attrs_array
    [@directory, @file_name, @longitude, @latitude]
  end
end
