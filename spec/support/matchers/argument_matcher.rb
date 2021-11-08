# frozen_string_literal: true

RSpec::Matchers.define :have_arguments do |expected|
  match do |actual|
    @actual = actual.argument_names

    expect(actual.argument_names).to include expected
  end
end

RSpec::Matchers.alias_matcher :have_argument, :have_arguments
