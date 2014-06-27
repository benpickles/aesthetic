require 'aesthetic/version'
require 'pathname'

module Aesthetic
  class << self
    def current
      tmp.join('current')
    end

    def diff
      tmp.join('diffs')
    end

    def good
      Pathname.new('aesthetic')
    end

    def tmp
      Pathname.new('tmp/aesthetic')
    end
  end
end
