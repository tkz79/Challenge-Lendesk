$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'spec_helper'
require 'templates/csv'
require 'image'

RSpec.describe Templates::Csv, type: :aruba do
  before(:all) {
    setup_aruba
    Dir.chdir('tmp/aruba')
  }
  after(:all) {
    Dir.chdir('../..')
  }

  let(:attr_labels) { %w[directory file_name latitude longitude] }
  let(:output_file) { Templates::Csv.new('images', attr_labels) }
  let(:image) { Image.new('../images/image_a.jpg') }
  let(:image_name) { 'image_a.jpg' }

  context 'responds to its methods' do
    it { expect(output_file).to respond_to(:insert) }
    it { expect(output_file).to respond_to(:close) }
  end

  context 'file creation' do
    it 'file exists' do
      setup_aruba
      expect(File.exists?(output_file.file_name)).to be_truthy
    end
    it 'label row was added' do
      output_file.close
      contents = File.open(output_file.file_name, "r").read
      expect(contents).to include(attr_labels.join(','))
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

end
