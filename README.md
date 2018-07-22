image_gps.rb -- Find JPEG images and extract their GPS coordinates

# DESCRIPTION

image_gps.rb is a utility that finds all JPEGs inside of a folder recursively,
and extracts their EXIF GPS data if present. It will default to scanning the
pwd unless a directory is provided as an argument.

Results are written to a file in the pwd as the scan runs. CSV files will be
produced by default, use -html for HTML files instead. If the app is not
installed as a gem, the HTML output requires configuration when being called
from outside the app folder.


# SYNOPSIS

Usage: image_gps.rb [options] [/target/folder/path]

image_gps.rb
image_gps.rb -v
image_gps.rb /home
image_gps.rb -html /home


# OPTIONS

--help        - provide brief help notice
-html         - outputs an HTML document rather than a CSV
-v, --verbose - outputs additional information as the script runs


# CONFIG

In order to use the -html option, the application needs to be able to locate the
html templates folder. This is automatic when the gem installed, but running the
script without installing it requires a config file in your home directory with
the full path to the app's root folder. A sample file is in the config folder.


# OUTPUT

The output file is created in the pwd, which requires write permission.

  imagegps_{folder_name}_{timestamp}.{csv|html}


# EXIT CODES

0 - success
1 - unsupported options
2 - unable to set directory for scan
3 - unable to create output file
4 - unable to scan directory
5 - exception while writing to output file

# FILES

`bin/image_gps.rb`
`lib/image.rb`
`lib/scanner.rb`
`lib/image_gps/version.rb`
`lib/templates/csv.rb`
`lib/templates/html.rb`
`lib/templates/html/_header.erb.html`
`lib/templates/html/_row.erb.html`
`lib/templates/html/_footer.erb.html`

# INSTALL NOTES

To install as a gem, type the following with correct version in app root:
  gem install pkg/image_gps-0.0.1.gem


# BUGS

1. Circular symbolic links are not handled


# AUTHOR

Tom Kulmacz


# TASK DESCRIPTION

Using Ruby, create a command line application that recursively reads all of the
images from the supplied directory of images, extracts their EXIF GPS data
(longitude and latitude), and then writes the name of that image and any GPS
co-ordinates it finds to a CSV file.

This utility should be executable from the command line (i.e.: ‘ruby ./app.rb’
or as an executable).

With no parameters, the utility should default to scanning from the current
directory. It should take an optional parameter that allows any other directory
to be passed in.

As a bonus, output either CSV or HTML, based on a parameter passed in via the
command line.

Feel free to use any gem(s) you like in your submission.
