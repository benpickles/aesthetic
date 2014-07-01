require 'aesthetic'
require 'aesthetic/diff'
require 'aesthetic/runner'

module Aesthetic
  class CLI
    def initialize(stdout, argv)
      @stdout = stdout
      @command = argv.first
      @argv = argv
    end

    def start
      case command
      when 'diff'    then diff
      when 'promote' then promote
      else standalone
      end
    end

    private
      attr_reader :argv, :command, :stdout

      def currents
        current = Aesthetic.current
        current.exist? ? current.children : []
      end

      def diff
        currents.map(&Diff).each(&:run)
      end

      def empty_tmp
        return unless Aesthetic.tmp.exist?
        Aesthetic.tmp.children.each(&:rmtree)
      end

      def promote
        currents.each do |path|
          good_path = Aesthetic.good.join(path.basename)
          path.rename(good_path)
        end
      end

      def standalone
        empty_tmp
        Runner.new(argv).run
      end

      def usage
        stdout.puts <<-USAGE
Usage:
  aesthetic FILENAME - Execute an Aesthetic script.
  aesthetic diff     - Diff "current" screenshots against their "known good"
                       counterparts.
  aesthetic promote  - Promote "current" screenshots to "known good".
USAGE
      end
  end
end
