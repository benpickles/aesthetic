module Aesthetic
  class ExampleBodyRecorder
    attr_reader :screenshots

    def initialize(&body)
      @screenshots = []
      instance_eval &body
    end

    def screenshot(name)
      screenshots << name.to_s
    end

    def method_missing(*args)
      # Do nothing.
    end
  end
end
