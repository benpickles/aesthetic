module Aesthetic
  class CLI
    def initialize(stdout, argv)
      @stdout = stdout
      @command = argv.first
    end

    def start
      if command.nil?
        usage
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

      def usage
        stdout.puts <<-USAGE
Usage:
  aesthetic FILENAME - Execute an Aesthetic script.
USAGE
      end
  end
end
