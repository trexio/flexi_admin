# frozen_string_literal: true

module FlexiAdmin::Models
  class Toast
    DELAY = 4
    attr_reader :message, :options, :autohide, :delay_sec

    def initialize(message, **options)
      @message = message
      @options = options
      @autohide = options.fetch(:autohide, true)
      @delay_sec = options.fetch(:delay, DELAY)
    end

    def to_s
      message
    end

    def delay
      delay_sec * 1000
    end
  end
end
