require 'aesthetic/breakpoint'
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
      @breakpoints = []
      @examples = []
    end

    def breakpoint(name, width)
      breakpoints << Breakpoint.new(name, width)
    end

    def example(name = nil, &block)
      examples << Example.new(name, &block)
    end

    def run
      instance_eval &body

      examples.each do |example|
        if breakpoints.any?
          breakpoints.each do |breakpoint|
            example.breakpoint = breakpoint
            example.run
          end
        else
          example.run
        end
      end
    end

    def screenshot(name, url)
      example do
        visit url
        screenshot name
      end
    end

    private
      attr_reader :body, :breakpoints, :examples
  end
end
