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

  def self.screenshot(session, path)
    screenshots.save(session, path)
  end

  def self.screenshots
    @screenshots ||= Screenshots.new(config)
  end
end
