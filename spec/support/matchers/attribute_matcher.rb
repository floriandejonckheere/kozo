# frozen_string_literal: true

RSpec::Matchers.define :have_attributes do |expected|
  match do |actual|
    @actual = actual.argument_names

    expect(actual.argument_names).to include expected
  end
end

RSpec::Matchers.alias_matcher :have_attribute, :have_attributes
