require 'aesthetic'

module Aesthetic
  module RSpecHelpers
    PREFIX = /^r_spec\/example_groups\//

    def screenshot
      directory = self.class.to_s.underscore.sub(PREFIX, '')
      Aesthetic.screenshot(page, directory)
    end
  end
end
