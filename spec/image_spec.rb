require 'spec_helper'
require 'aesthetic/image'

describe Aesthetic::Image do
  let(:path) { fixture('bag_frame1.gif') }
  let(:image) { Aesthetic::Image.new(path) }

  describe '#height' do
    subject { image.height }
    it { should eql(92) }
  end

  describe '#width' do
    subject { image.width }
    it { should eql(97) }
  end
end
