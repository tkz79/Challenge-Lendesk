$:.push File.expand_path("../lib", __FILE__)

require 'image_gps/version'

Gem::Specification.new do |s|
  s.name        = ImageGps::NAME
  s.version     = ImageGps::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tom Kulmacz"]
  s.email       = ["tomek.kulmacz@gmail.com"]
  s.homepage    = "https://github.com/tkz79"
  s.summary     = %q{CL app to find JPEGs and extract their GPS coordinates}
  s.description = %q{
    image_gps.rb is a utility that finds all JPEGs inside of a folder recursively,
    and extracts their EXIF GPS data if present. It will default to scanning the
    pwd unless a directory is provided as an argument.

    Results are written to a file in the pwd as the scan runs. CSV files will be
    produced by default, use -html for HTML files instead. If the app is not
    installed as a gem, HTML output requires configuration.
  }

  s.rubyforge_project = "db_backup"

  s.files = %w(
    bin/image_gps.rb
    lib/image.rb
    lib/scanner.rb
    lib/image_gps/version.rb
    lib/templates/csv.rb
    lib/templates/html.rb
    lib/templates/html/_header.html.erb
    lib/templates/html/_row.html.erb
    lib/templates/html/_footer.html.erb
  )
  s.executables = ['image_gps.rb']
  s.add_development_dependency('aruba', '~> 0.14.6')
  s.add_development_dependency('exifr', '~> 1.3', '>= 1.3.4')
  s.add_development_dependency('rake', '~> 12.3', '>= 12.3.1')
  s.add_development_dependency('rspec', '~> 3.7')
end
