require 'aesthetic/rspec_helpers'
require 'rspec/core'

RSpec.configure do |config|
  config.include Aesthetic::RSpecHelpers, type: :feature
  config.include Aesthetic::RSpecHelpers, type: :system
end
