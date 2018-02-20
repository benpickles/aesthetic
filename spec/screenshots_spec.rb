describe Aesthetic::Screenshots do
  describe '#save' do
    let(:config) { Aesthetic::Config.new(root: 'tmp') }
    let(:screenshots) { Aesthetic::Screenshots.new(config) }

    context 'file naming' do
      let(:session) { double }

      context 'when called multiple times (with out of order paths)' do
        it 'numbers the files correctly' do
          foo1 = Pathname.new('tmp/screenshots/foo-001.png')
          foo2 = Pathname.new('tmp/screenshots/foo-002.png')
          bar1 = Pathname.new('tmp/screenshots/bar-001.png')

          expect(session).to receive(:save_screenshot).with(foo1, anything)
          expect(session).to receive(:save_screenshot).with(foo2, anything)
          expect(session).to receive(:save_screenshot).with(bar1, anything)

          screenshots.save(session, 'foo')
          screenshots.save(session, 'bar') # <- Out of order.
          screenshots.save(session, 'foo')
        end
      end
    end
  end
end
