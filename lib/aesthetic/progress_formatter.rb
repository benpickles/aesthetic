require 'aesthetic/formatter'

module Aesthetic
  class ProgressFormatter < Formatter
    def diff
      out.print '.'
    end

    def example
      out.print '.'
    end

    def finish
      out.puts
    end

    def promote
      out.print '.'
    end
  end
end
