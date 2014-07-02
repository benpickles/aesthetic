require 'active_support/notifications'

module Aesthetic
  module Notifications
    class << self
      def emit(name)
        ActiveSupport::Notifications.instrument(name)
      end

      def subscribe(subscriber)
        ActiveSupport::Notifications.subscribe(nil, subscriber)
      end
    end
  end
end
