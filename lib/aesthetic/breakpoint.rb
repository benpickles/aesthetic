module Aesthetic
  class Breakpoint
    attr_reader :name, :width

    def initialize(name, width)
      @name = name
      @width = width
    end
  end
end
