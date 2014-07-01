require 'spec_helper'
require 'aesthetic/example'

describe Aesthetic::Example do
  describe '#has_screenshot?' do
    subject { Aesthetic::Example.new(&body) }

    context 'when the example has no screenshots' do
      let(:body) { proc {} }
      it { should_not have_screenshot('foo') }
    end

    context 'when the example has a screenshot named :home' do
      let(:body) {
        proc {
          visit '/'
          screenshot :home
        }
      }

      it { should_not have_screenshot('foo') }
    end

    context 'when the example has multiple screenshots including one named :foo' do
      let(:body) {
        proc {
          visit '/'
          screenshot :home
          click_link 'Foo'
          screenshot :foo
        }
      }

      it { should have_screenshot('foo') }
    end
  end
end
