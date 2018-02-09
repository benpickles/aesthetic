module Aesthetic
  class Screenshots
    attr_reader :counter, :root

    def initialize(root)
      @root = root
      @counter = Hash.new { |hash, key| hash[key] = 0 }
    end

    def save(session, directory)
      count = counter[directory] += 1
      number = sprintf("%03d", count)
      path = root.join("#{directory}-#{number}.png")
      session.save_screenshot(path, full: true)
      path
    end
  end
end
