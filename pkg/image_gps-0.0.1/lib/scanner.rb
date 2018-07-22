$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'pathname'
require 'image'

# Scans a directory for images matching @formats
#
#   directory: Pathname object of directory to scan
#   output_file: Output file object to write to
#   verbose: boolean for verbose mode
class Scanner
  def initialize(directory, output_file, verbose)
    @directory = Pathname.new(directory)
    @output_file = output_file
    @verbose = verbose
    @formats = ['.jpg', '.jpeg']
  end

  def begin_scan
    scan_directory(@directory)
  end

  private

  # Recursively scans directory searching for image files
  #
  #   dir: a Pathname object of directory
  def scan_directory(dir)
    p "scanning path: #{dir}" if @verbose

    dir.children.each do |child|
      if child.file? && @formats.include?(File.extname(child).downcase)
        begin
          @output_file.insert(Image.new(child.to_path).attrs_array)
        rescue EXIFR::MalformedJPEG => e
          handle_warning('malformed_jpeg', e, child.to_path) if @verbose
        rescue SystemCallError => e
          p "An error occurred while processing image: #{child.to_path}"
          raise SystemCallError, "The error received was: #{e}"
        end

      elsif child.directory?
        begin
          scan_directory(child)
        rescue SystemCallError => e
          handle_warning('unscannable_directory', e, child.to_path) if @verbose
        end
      end
    end
  end

  # Handles warning messages in verbose mode
  #
  #   kind: type of error to handle
  #   exception: exception thrown
  #   file: file or directory error was encountered on
  def handle_warning(kind, exception, file)
    case kind
    when 'malformed_jpeg'
      p "Unprocessible image: #{file}"
      p exception.message
    when 'unscannable_directory'
      p "Unscannable sub directory: #{file}"
      p exception.message
    end
  end
end
