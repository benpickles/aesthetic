require 'aesthetic'
require 'aesthetic/diff'

module Aesthetic
  class CLI
    def initialize(stdout, argv)
      @stdout = stdout
      @command = argv.first
    end

    def start
      if command.nil?
        usage
      elsif command == 'diff'
        diff
      elsif File.exist?(command)
        require 'aesthetic/standalone'
        path = File.expand_path(command, Dir.pwd)
        load path
      else
        usage
      end
    end

    private
      attr_reader :command, :stdout

      def currents
        current = Aesthetic.current
        current.exist? ? current.children : []
      end

      def diff
        currents.map(&Diff).each(&:run)
      end

      def usage
        stdout.puts <<-USAGE
Usage:
  aesthetic FILENAME - Execute an Aesthetic script.
  aesthetic diff     - Diff "current" screenshots against their "known good"
                       counterparts.
USAGE
      end
  end
end
