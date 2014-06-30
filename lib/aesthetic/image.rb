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
        @dimensions ||= IO.popen(['identify', '-format', '%w %h', path.to_s]) { |io|
          io.read.split(' ').map(&:to_i)
        }
      end
  end
end
