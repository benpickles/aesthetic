describe Aesthetic do
  describe '#configure' do
    let(:config) { Aesthetic.config }

    it do
      Aesthetic.configure do |c|
        c.directory = 'foo'
      end

      expect(config.directory).to eql('foo')
    end
  end
end
