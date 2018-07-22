#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'optparse'
require 'scanner'
require 'templates/csv'
require 'templates/html'

# Wrapper for script logic
#
#   options: command line options from OptionParser
#   args: the ARGV array
#
#   Exit Codes
#     0: success
#     1: unsupported options
#     2: unable to set directory for scan
#     3: unable to create output file
#     4: unable to scan directory
#     5: exception while writing to output file
def main(options, args)
  verbose = options[:verbose]

  p 'Setting directory to scan' if verbose
  begin
    directory = set_dir(args, Dir.pwd)
  rescue ArgumentError => e
    STDERR.puts 'Unable to set root directory'
    STDERR.puts e.message
    exit(2)
  end

  p 'Initializing output file' if verbose
  begin
    output_file = initialize_output_file(options, directory)
  rescue SystemCallError => e
    STDERR.puts 'Unable to initialize the output file'
    STDERR.puts 'Make sure you have write permission to your pwd'
    if options[:html]
      STDERR.puts 'If you have not installed the gem, check your config file'
    end
    STDERR.puts e.message
    exit(3)
  end

  p 'Initializing scanner' if verbose
  scanner = Scanner.new(directory, output_file, verbose)
  begin
    p 'Starting scan' if verbose
    scanner.begin_scan
  rescue SystemCallError => e
    STDERR.puts 'Unable to scan this directory'
    STDERR.puts e.message
    exit(4)
  rescue StandardError => e
    STDERR.puts e.message
    exit(5)
  end
  p 'Scan Completed' if verbose

  p 'Closing output file' if verbose
  output_file.close

  p 'Exiting Successfully' if verbose
  p "Output file: #{output_file.file_name}"
  exit(0)
end


# Sets the directory to be scanned
#
#   args: the ARGV array
#   pwd: present working dir
#
#   Returns: absolute directory path
def set_dir(args, pwd)
  case args.count
  when 0
    pwd
  when 1
    File.absolute_path(args.first)
  else
    raise ArgumentError, 'Too many arguments passed'
  end
end

# Sets the directory to be scanned
#
#   options: command line options from OptionParser
#   directory: path of directory to scan
#
#   Returns: Output file object
def initialize_output_file(options, directory)
  attr_labels = %w[directory file_name latitude longitude]
  dir_name = File.basename(directory)
  if options[:html]
    Templates::Html.new(dir_name, attr_labels)
  else
    Templates::Csv.new(dir_name, attr_labels)
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  executable_name = File.split($PROGRAM_NAME)[1]
  opts.banner = <<-EOS
Finds JPEG files in a folder, extracts their GPS EXIF data, prints to file.
See README.md for full details

Usage: #{executable_name} [options] [/target/folder/path]

Options are:
  EOS

  opts.on('-html', 'Output HTML file') do
    options[:html] = true
  end

  opts.on('-v', '--verbose', 'Run verbosely') do |v|
    options[:verbose] = v
  end
end

begin
  option_parser.parse!
rescue OptionParser::InvalidOption => e
  STDERR.puts e.message
  STDERR.puts option_parser
  exit(1)
end

main(options, ARGV)
