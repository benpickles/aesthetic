require 'aesthetic/standalone'
require 'optparse'

module Aesthetic
  class Runner
    Aestheticfile = 'Aestheticfile'

    def initialize(stdout, stderr, argv)
      @stdout = stdout
      @stderr = stderr
      @argv = argv
      @standalone = Standalone.new(extract_options!)
    end

    def aesthetic(&block)
      standalone.body(&block)
    end

    def run
      instance_eval(contents, path, 1)
      standalone.run
    end

    private
      attr_reader :argv, :standalone, :stderr, :stdout

      def contents
        if File.exist?(path)
          File.read(path)
        else
          stderr.puts "#{path} not found."
          ''
        end
      end

      def extract_options!
        options = {}

        OptionParser.new { |opts|
          opts.banner = 'Usage: aesthetic [run] [options] [file]'

          opts.on '-s [OPTIONAL]', '--screenshot [OPTIONAL]' do |value|
            options[:screenshot] = value
          end

          opts.on_tail '--help' do
            puts opts
            exit
          end
        }.parse!(argv)

        options
      end

      def path
        @path ||= argv.first || Aestheticfile
      end
  end
end
