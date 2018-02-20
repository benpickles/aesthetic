require 'aesthetic/config'

describe Aesthetic::Config do
  describe 'initializing with values' do
    subject { described_class.new(opts) }

    context 'when the setting exists' do
      let(:opts) { { directory: 'tmp' } }

      it do
        expect(subject.directory).to eql('tmp')
      end
    end

    context 'when the setting does not exist' do
      let(:opts) { { foo: 'bar' } }

      it do
        expect {
          subject
        }.to raise_error(NoMethodError)
      end
    end
  end
end
