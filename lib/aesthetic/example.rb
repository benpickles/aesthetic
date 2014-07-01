require 'aesthetic'
require 'aesthetic/breakpoint'
require 'aesthetic/example_body_recorder'
require 'capybara'
require 'capybara/poltergeist'

module Aesthetic
  class Example
    include Capybara::DSL

    attr_reader :body, :breakpoint, :host, :name

    def initialize(name = nil, &body)
      @name = name
      @body = body
      @breakpoint = Breakpoint.new(nil, nil)
      @host = nil
    end

    def breakpoint=(bp)
      @breakpoint = bp
      page.driver.resize(bp.width, 768)
    end

    def has_screenshot?(name)
      screenshots.include?(name)
    end

    def host=(value)
      Capybara.app_host = value
    end

    def page
      @page ||= Capybara::Session.new(:poltergeist)
    end

    def run
      instance_eval &body
    end

    def screenshot(name)
      image_name = [name, breakpoint.name].compact.join('-') << '.png'
      path = Aesthetic.good.join(image_name)
      path = Aesthetic.current.join(image_name) if path.exist?

      page.save_screenshot(path, full: true)
    end

    private
      def recording
        @recording ||= ExampleBodyRecorder.new(&body)
      end

      def screenshots
        recording.screenshots
      end
  end
end
