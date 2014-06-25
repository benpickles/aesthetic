require 'open3'

module Aesthetic
  class Image
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def height
      dimensions[1]
    end

    def width
      dimensions[0]
    end

    private
      def dimensions
        @dimensions ||= Open3.popen3('identify', '-format', '%w %h', path.to_s) { |_, stdout, _, _|
          stdout.read.split(' ').map(&:to_i)
        }
      end
  end
end
