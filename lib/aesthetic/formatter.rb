module Aesthetic
  class Formatter
    def initialize(out)
      @out = out
    end

    def call(name, _, _, _, _)
      case name
      when 'diff'    then diff
      when 'example' then example
      when 'finish'  then finish
      when 'promote' then promote
      end
    end

    def diff
    end

    def example
    end

    def finish
    end

    def promote
    end

    private
      attr_reader :out
  end
end
