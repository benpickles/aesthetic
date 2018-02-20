require 'aesthetic/rspec_screenshot_info'

describe Aesthetic::RSpecScreenshotInfo do
  subject { described_class.new(metadata) }

  context 'for a `describe`/`it`' do
    let(:metadata) {
      {
        description_args: ['Should do something'],
        example_group: {
          description_args: ['My Description'],
        }
      }
    }

    its(:path) { should eql('my_description/should_do_something') }
  end

  context 'when `it` is blank' do
    let(:metadata) {
      {
        description_args: [],
        example_group: {
          description_args: ['My Description'],
        }
      }
    }

    its(:path) { should eql('my_description') }
  end

  context 'with nested `context`s' do
    let(:metadata) {
      {
        description_args: ['Should do something'],
        example_group: {
          description_args: ['And another'],
          parent_example_group: {
            description_args: ['When foo bar'],
            parent_example_group: {
              description_args: ['My Description'],
            }
          }
        }
      }
    }

    its(:path) { should eql('my_description/when_foo_bar/and_another/should_do_something') }
  end

  context 'when some things are blank/empty' do
    let(:metadata) {
      {
        description_args: ['wow'],
        example_group: {
          description_args: [],
          parent_example_group: {
            description_args: [' '],
            parent_example_group: {
              description_args: ['Bottom-Level'],
            }
          }
        }
      }
    }

    its(:path) { should eql('bottom-level/wow') }
  end

  context 'when everything is blank/empty' do
    let(:metadata) {
      {
        description_args: [],
        example_group: {
          description_args: [' '],
          parent_example_group: {
            description_args: [],
            parent_example_group: {
              description_args: [],
            }
          }
        }
      }
    }

    its(:path) { should eql('') }
  end
end
