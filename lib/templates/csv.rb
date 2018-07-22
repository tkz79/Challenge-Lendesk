module Templates
  # This Class handles creating and writing CSV output files
  class Csv
    attr_reader :file_name

    # dir: basename of root directory
    # attr_labels: array of attributes labels as strings
    def initialize(dir, attr_labels)
      @file_name = "imagegps_#{dir}_#{Time.now.to_i}.csv"
      @file = File.new(@file_name, 'w')
      append_header(attr_labels)
    end

    # Writes data row to file
    #
    #   img_attrs: array of string attributes
    def insert(img_attrs)
      @file.puts(img_attrs.join(','))
    end

    def close
      @file.close
    end

    private

    # Writes the lables row of the file
    #
    #   attr_labels: an array of strings that define the attributes
    def append_header(attr_labels)
      @file.puts(attr_labels.join(','))
    end
  end
end
