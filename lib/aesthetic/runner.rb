require 'aesthetic/standalone'

module Aesthetic
  class Runner
    def initialize(path)
      @path = path
      @standalone = nil
    end

    def aesthetic(&block)
      @standalone = Standalone.new(&block)
    end

    def run
      instance_eval(contents, path, 1)
      standalone.run
    end

    private
      attr_reader :path, :standalone

      def contents
        File.read(path)
      end
  end
end
