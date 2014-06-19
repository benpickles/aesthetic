require 'aesthetic/example'
require 'capybara/poltergeist'

Capybara.current_driver = :poltergeist

def aesthetic(&block)
  Aesthetic::Standalone.new(&block).run
end

module Aesthetic
  class Standalone
    def initialize(&body)
      @body = body
      @examples = []
    end

    def example(name = nil, &block)
      examples << Example.new(name, &block)
    end

    def run
      instance_eval &body
      examples.each(&:run)
    end

    def screenshot(name, url)
      example do
        visit url
        screenshot name
      end
    end

    private
      attr_reader :body, :examples
  end
end
