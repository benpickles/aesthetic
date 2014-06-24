require 'pathname'

module Aesthetic
  class << self
    def current
      tmp.join('current')
    end

    def path
      Pathname.new('aesthetic')
    end

    def tmp
      Pathname.new('tmp/aesthetic')
    end
  end
end
