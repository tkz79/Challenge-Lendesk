require 'erb'

module Templates
  # This Class handles creating and writing HTML output files
  class Html
    attr_reader :file_name

    # dir: basename of root directory
    # attr_labels: array of attributes labels as strings
    def initialize(dir, attr_labels)
      @file_name = "imagegps_#{dir}_#{Time.now.to_i}.html"
      @file = File.new(@file_name, 'w')
      append_header(dir, attr_labels)
    end

    # Writes data row to file
    #
    #   img_attrs: array of string attributes
    def insert(img_attrs)
      @img_attrs = img_attrs
      row = File.read("lib/templates/html/_row.html.erb")
      partial = ERB.new(row, nil, '-').result(binding)
      @file.write(partial)
    end

    # Writes footer to file and closes it
    def close
      footer = File.read("lib/templates/html/_footer.html.erb")
      partial = ERB.new(footer).result(binding)
      @file.write(partial)
      @file.close
    end

    private

    # Writes the header component of the HTML file
    #
    #   dir: the basename of the root directory
    #   attr_labels: an array of strings that define the attributes
    def append_header(dir, attr_labels)
      @title = "Image GPS Scan for: #{dir}"
      @attr_labels = attr_labels
      header = File.read("lib/templates/html/_header.html.erb")
      partial = ERB.new(header, nil, '-').result(binding)
      @file.write(partial)
    end
  end
end
