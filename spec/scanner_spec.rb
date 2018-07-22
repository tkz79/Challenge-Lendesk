$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'spec_helper'
require 'scanner'
require 'templates/csv'

RSpec.describe Scanner, :type => :aruba do
  before(:all) {
    setup_aruba
    Dir.chdir('tmp/aruba')
  }
  after(:all) {
    Dir.chdir('../..')
  }

  let(:attr_labels) { %w[directory file_name latitude longitude] }
  let(:report) { Templates::Csv.new('images', attr_labels) }
  let(:scanner) { Scanner.new(Pathname.new('../images/'), report, false) }

  context 'responds to its methods' do
    it { expect(scanner).to respond_to(:begin_scan) }
  end

end
