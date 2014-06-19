require 'aesthetic'
require 'capybara/dsl'

module Aesthetic
  class Example
    include Capybara::DSL

    attr_reader :body, :name

    def initialize(name = nil, &body)
      @name = name
      @body = body
    end

    def run
      instance_eval &body
    end

    def screenshot(name)
      image_name = "#{name}.png"
      path = Aesthetic.path.join(image_name)

      page.save_screenshot(path, full: true)
    end
  end
end
