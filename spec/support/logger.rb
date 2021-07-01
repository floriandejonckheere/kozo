# frozen_string_literal: true

RSpec::Matchers.define :log do |expected|
  match do |actual|
    logger = double

    allow(Kozo)
      .to receive(:logger)
      .and_return logger

    allow(logger)
      .to receive(:info) { |s| (@messages ||= []) << s }
      .and_return nil

    actual.call

    expect(logger)
      .to have_received(:info)
      .with(expected)
  end

  failure_message do |_actual|
    messages = @messages
      &.map
      &.with_index { |m, i| m.prepend("#{(i + 1).to_s.rjust(5)}) ") }
      &.join("\n")

    "expected block to log #{expected}, but received:\n#{messages}"
  end

  supports_block_expectations
end
