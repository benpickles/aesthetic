require 'aesthetic'
require 'aesthetic/diff'
require 'aesthetic/progress_formatter'
require 'aesthetic/notifications'
require 'aesthetic/runner'
require 'aesthetic/version'
require 'optparse'

module Aesthetic
  class CLI
    def initialize(stdout, stderr, argv)
      @stdout = stdout
      @stderr = stderr
      @argv = argv
    end

    def start
      command = argv.first

      extract_options! unless command == 'run'

      case command
      when 'diff'     then diff
      when 'promote'  then promote
      when 'run'
        argv.shift
        runner
      else
        runner
      end

      Notifications.emit('finish')
    end

    private
      attr_reader :argv, :stderr, :stdout

      def currents
        current = Aesthetic.current
        current.exist? ? current.children : []
      end

      def diff
        subscribe
        currents.map(&Diff).each(&:run)
      end

      def empty_tmp
        return unless Aesthetic.tmp.exist?
        Aesthetic.tmp.children.each(&:rmtree)
      end

      def extract_options!
        OptionParser.new { |opts|
          opts.banner = 'Usage: aesthetic [options] [command]'
          opts.separator ''
          opts.separator '  Commands:'
          opts.separator '    diff    - Diff "current" screenshots against their "known good" counterparts.'
          opts.separator '    promote - Move "current" screenshots to the "known good" directory.'
          opts.separator '    run     - Execute an Aesthetic script (the default command).'
          opts.separator ''
          opts.separator '  Options:'

          opts.on_tail '-h', '--help', 'Show this helpful message.' do
            puts opts
            exit
          end

          opts.on_tail '-v', '--version', 'What version of Aesthetic is this?' do
            puts VERSION
            exit
          end
        }.parse(argv)
      rescue OptionParser::InvalidOption
        # Allow unknown options to reach sub-commands.
      end

      def promote
        subscribe

        currents.each do |path|
          Notifications.emit('promote')
          good_path = Aesthetic.good.join(path.basename)
          path.rename(good_path)
        end
      end

      def runner
        empty_tmp
        subscribe
        Runner.new(stdout, stderr, argv).run
      end

      def subscribe
        formatter = ProgressFormatter.new(stdout)
        Notifications.subscribe(formatter)
      end
  end
end
