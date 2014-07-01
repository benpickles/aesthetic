require 'aesthetic/breakpoint'
require 'aesthetic/example'

module Aesthetic
  class Standalone
    def initialize
      @breakpoints = []
      @examples = []
      @_host = nil
    end

    def body(&block)
      instance_eval &block
    end

    def breakpoint(name, width)
      breakpoints << Breakpoint.new(name, width)
    end

    def example(name = nil, &block)
      examples << Example.new(name, &block)
    end

    def host(value)
      @_host = value
    end

    def run
      examples.each do |example|
        if breakpoints.any?
          breakpoints.each do |breakpoint|
            example.breakpoint = breakpoint
            example.host = _host if _host
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
      attr_reader :_host, :breakpoints, :examples
  end
end
