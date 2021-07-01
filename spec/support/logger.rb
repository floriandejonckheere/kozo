# frozen_string_literal: true

RSpec::Matchers.define :log do |expected|
  match do |actual|
    logger = double

    # Mock Kozo.logger
    allow(Kozo)
      .to receive(:logger)
      .and_return logger

    # Store logs with level 'info'
    allow(logger)
      .to receive(:info) { |s| (@messages ||= []) << s }
      .and_return nil

    # Discard logs with other levels
    [:error, :warn, :debug].each do |level|
      allow(logger)
        .to receive(level)
        .and_return nil
    end

    actual.call

    expect(@messages)
      .to include expected
  end

  failure_message do |_actual|
    messages = @messages
      &.map
      &.with_index { |m, i| m.prepend("\n#{(i + 1).to_s.rjust(5)}) ") } || "nothing"

    "expected block to log #{expected}, but received #{messages}"
  end

  supports_block_expectations
end
