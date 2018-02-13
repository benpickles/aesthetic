require 'aesthetic'
require 'active_support/inflector/methods'

module Aesthetic
  module RSpecHelpers
    PREFIX = /^r_spec\/example_groups\//

    def screenshot
      directory = ActiveSupport::Inflector.underscore(
        self.class.to_s
      ).sub(PREFIX, '')

      Aesthetic.screenshot(page, directory)
    end
  end
end
