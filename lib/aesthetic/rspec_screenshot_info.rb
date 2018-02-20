require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module Aesthetic
  class RSpecScreenshotInfo
    attr_reader :metadata

    def initialize(metadata)
      @metadata = metadata
    end

    def path
      descriptions
        .reject(&:blank?)
        .map { |part| part.parameterize(separator: '_') }
        .join('/')
    end

    private
      def descriptions
        [].tap { |list|
          group = metadata.fetch(:example_group)

          loop do
            list.unshift(group.fetch(:description_args).first)
            group = group[:parent_example_group]
            break unless group
          end

          list << metadata.fetch(:description_args).first
        }
      end
  end
end
