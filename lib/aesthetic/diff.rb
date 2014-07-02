require 'aesthetic'
require 'aesthetic/image'
require 'aesthetic/notifications'
require 'fileutils'

module Aesthetic
  class Diff
    def self.to_proc
      ->(path) { new(path) }
    end

    def initialize(path)
      @path = path
    end

    def run
      Notifications.emit('diff')

      FileUtils.mkdir_p(normalised_current.dirname)
      FileUtils.mkdir_p(normalised_good.dirname)
      FileUtils.mkdir_p(diff.dirname)

      resize(current.path, normalised_current)
      resize(good.path, normalised_good)

      system 'compare', normalised_good.to_s, normalised_current.to_s, diff.to_s
    end

    private
      attr_reader :path

      def current
        @current ||= Image.new(path)
      end

      def diff
        Aesthetic.diff.join(name)
      end

      def good
        @good ||= begin
          path = Aesthetic.good.join(name)
          Image.new(path)
        end
      end

      def name
        path.basename
      end

      def max_height
        [current, good].map(&:height).max
      end

      def max_width
        [current, good].map(&:width).max
      end

      def normalised_current
        Aesthetic.tmp.join('normalised_current').join(name)
      end

      def normalised_good
        Aesthetic.tmp.join('normalised_good').join(name)
      end

      def resize(from, to)
        system 'convert', '-background', 'none', '-extent', "#{max_width}x#{max_height}", from.to_s, to.to_s
      end
  end
end
