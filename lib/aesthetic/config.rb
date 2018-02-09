require 'pathname'

module Aesthetic
  class Config
    DIRECTORY = 'screenshots'
    ROOT = Dir.pwd

    attr_accessor :directory, :root

    def initialize
      @directory = DIRECTORY
      @root = ROOT
    end

    def path
      Pathname.new(root).join(directory)
    end
  end
end
