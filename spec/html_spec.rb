$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'spec_helper'
require 'templates/html'
require 'image'

RSpec.describe Templates::Html, type: :aruba do
  before(:all) {
    setup_aruba
    Dir.chdir('tmp/aruba')
  }
  after(:all) {
    Dir.chdir('../..')
  }

  let(:attr_labels) { %w[directory file_name latitude longitude] }
  let(:output_file) { Templates::Html.new('images', attr_labels) }
  let(:image) { Image.new('../images/image_a.jpg') }
  let(:image_name) { 'image_a.jpg' }

  context 'file creation' do
    it 'file exists' do
      setup_aruba
      expect(File.exists?(output_file.file_name)).to be_truthy
    end
    it 'appends header' do
      output_file.close
      contents = File.open(output_file.file_name, "r").read
      expect(contents).to include("<html>")
    end
  end

  context 'file insertion' do
    it 'inserts rows for images' do
      output_file.insert(image.attrs_array)
      output_file.close
      contents = File.open(output_file.file_name, "r").read
      expect(contents).to include(image_name)
    end
  end

  context 'closing file' do
    it 'inserts rows for images' do
      output_file.insert(image.attrs_array)
      output_file.close
      contents = File.open(output_file.file_name, "r").read
      expect(contents).to include(image_name)
    end
    it 'appends footer' do
      output_file.close
      contents = File.open(output_file.file_name, "r").read
      expect(contents).to include("</html>")
    end
  end
end
