require 'aesthetic'
require 'aesthetic/rspec_screenshot_info'

module Aesthetic
  module RSpecHelpers
    def screenshot
      info = RSpecScreenshotInfo.new(RSpec.current_example.metadata)
      Aesthetic.screenshot(page, info.path)
    end
  end
end
