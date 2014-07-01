require 'aesthetic/standalone'

module Aesthetic
  class Runner
    Aestheticfile = 'Aestheticfile'

    def initialize(stdout, stderr, args)
      @stdout = stdout
      @stderr = stderr
      @args = args
      @standalone = Standalone.new
    end

    def aesthetic(&block)
      standalone.body(&block)
    end

    def run
      instance_eval(contents, path, 1)
      standalone.run
    end

    private
      attr_reader :args, :standalone, :stderr, :stdout

      def contents
        if File.exist?(path)
          File.read(path)
        else
          stderr.puts "#{path} not found."
          ''
        end
      end

      def path
        @path ||= args.first || Aestheticfile
      end
  end
end
