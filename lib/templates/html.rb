# frozen_string_literal: true

$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'erb'
require 'yaml'
require 'image_gps/version'

module Templates
  # This Class handles creating and writing HTML output files
  class Html
    attr_reader :file_name

    # dir: basename of root directory
    # attr_labels: array of attributes labels as strings
    def initialize(dir, attr_labels)
      @file_name = "imagegps_#{dir}_#{Time.now.to_i}.html"
      @file = File.new(@file_name, 'w')
      @template_path = set_template_path
      append_header(dir, attr_labels)
    end

    # Writes data row to file
    #
    #   img_attrs: array of string attributes
    def insert(img_attrs)
      @img_attrs = img_attrs
      row = File.read("#{@template_path}_row.html.erb")
      partial = ERB.new(row, nil, '-').result(binding)
      @file.write(partial)
    end

    # Writes footer to file and closes it
    def close
      footer = File.read("#{@template_path}_footer.html.erb")
      partial = ERB.new(footer).result(binding)
      @file.write(partial)
      @file.close
    end

    private

    # Attempts to locate path to templates
    def set_template_path
      template_path = 'lib/templates/html/'

      gem_path = "#{Gem.dir}/gems/#{ImageGps::NAME}-#{ImageGps::VERSION}/"
      return File.join(gem_path, template_path) if File.exists?(gem_path)

      config_file = File.join(ENV['HOME'],'.image_gps.yaml')
      if File.exists?(config_file)
        app_path = YAML.load_file(config_file)['app_path']
        File.join(app_path, template_path)
      else
        template_path # Fallback in case user is inside app folder
      end
    end

    # Writes the header component of the HTML file
    #
    #   dir: the basename of the root directory
    #   attr_labels: an array of strings that define the attributes
    def append_header(dir, attr_labels)
      @title = "Image GPS Scan for: #{dir}"
      @attr_labels = attr_labels
      header = File.read("#{@template_path}_header.html.erb")
      partial = ERB.new(header, nil, '-').result(binding)
      @file.write(partial)
    end
  end
end
