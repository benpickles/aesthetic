require 'aesthetic/config'
require 'aesthetic/screenshots'
require 'aesthetic/version'

module Aesthetic
  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield config
  end

  def self.screenshot(session, directory)
    @screenshots ||= Screenshots.new(config.path)
    @screenshots.save(session, directory)
  end
end
