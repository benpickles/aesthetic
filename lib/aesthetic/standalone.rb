require 'aesthetic/breakpoint'
require 'aesthetic/example'

module Aesthetic
  class Standalone
    def initialize(&body)
      @body = body
      @breakpoints = []
      @examples = []
      @_host = nil
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
      instance_eval &body

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
      attr_reader :_host, :body, :breakpoints, :examples
  end
end
