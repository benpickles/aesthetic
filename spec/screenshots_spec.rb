describe Aesthetic::Screenshots do
  describe '#save' do
    let(:screenshots) { Aesthetic::Screenshots.new(root) }

    context 'file naming' do
      let(:root) { Pathname.new('tmp') }
      let(:session) { double }

      context 'when called multiple times (with out of order directories)' do
        it 'numbers the files correctly' do
          foo1 = Pathname.new('tmp/foo-001.png')
          foo2 = Pathname.new('tmp/foo-002.png')
          bar3 = Pathname.new('tmp/bar-001.png')

          expect(session).to receive(:save_screenshot).with(foo1, anything)
          expect(session).to receive(:save_screenshot).with(foo2, anything)
          expect(session).to receive(:save_screenshot).with(bar3, anything)

          screenshots.save(session, 'foo')
          screenshots.save(session, 'bar') # <- Out of order.
          screenshots.save(session, 'foo')
        end
      end
    end
  end
end
