require 'aesthetic/breakpoint'
require 'aesthetic/example'

module Aesthetic
  class Standalone
    def initialize(opts)
      @opts = opts
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
      filtered_examples.each do |example|
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
      attr_reader :_host, :breakpoints, :examples, :opts

      def filtered_examples
        screenshot_filter = opts[:screenshot]

        if screenshot_filter
          examples.select { |example|
            example.has_screenshot?(screenshot_filter)
          }
        else
          examples
        end
      end
  end
end
