require 'pathname'

module Aesthetic
  class Config
    DEFAULTS = {
      active: true,
      directory: 'screenshots',
      root: Dir.pwd,
    }

    attr_accessor :active, :directory, :root

    def initialize(opts = {})
      DEFAULTS.merge(opts).each do |key, value|
        self.public_send("#{key}=", value)
      end
    end

    def path
      Pathname.new(root).join(directory)
    end
  end
end
