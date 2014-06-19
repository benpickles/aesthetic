require 'aesthetic'
require 'aesthetic/breakpoint'
require 'capybara/dsl'

module Aesthetic
  class Example
    include Capybara::DSL

    attr_reader :body, :breakpoint, :name

    def initialize(name = nil, &body)
      @name = name
      @body = body
      @breakpoint = Breakpoint.new(nil, nil)
    end

    def breakpoint=(bp)
      @breakpoint = bp
      page.driver.resize(bp.width, 768)
    end

    def run
      instance_eval &body
    end

    def screenshot(name)
      image_name = [name, breakpoint.name].compact.join('-') << '.png'
      path = Aesthetic.path.join(image_name)

      page.save_screenshot(path, full: true)
    end
  end
end
