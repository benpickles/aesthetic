require 'pathname'

module Aesthetic
  class << self
    def path
      Pathname.new('aesthetic')
    end
  end
end
