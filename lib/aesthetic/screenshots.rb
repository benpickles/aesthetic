module Aesthetic
  class Screenshots
    attr_reader :config, :counter

    def initialize(config)
      @config = config
      @counter = Hash.new { |hash, key| hash[key] = 0 }
    end

    def save(session, directory)
      count = counter[directory] += 1
      number = sprintf("%03d", count)
      path = config.path.join("#{directory}-#{number}.png")
      session.save_screenshot(path, full: true)
    end
  end
end
