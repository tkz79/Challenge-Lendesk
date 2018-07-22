$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'spec_helper'
require 'exifr/jpeg'
require 'image'

RSpec.describe Image do
  let(:image) { Image.new('tmp/images/image_a.jpg') }

  context 'responds to its methods' do
    it { expect(image).to respond_to(:attrs_array) }
  end

  context 'executes methods correctly' do
    it 'returns its attr array' do
      expect(image.attrs_array).to eq(["tmp/images", "image_a.jpg", -122.94566666666667, 50.09133333333333])
    end
  end
end
