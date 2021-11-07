# frozen_string_literal: true

RSpec::Matchers.define :have_associations do |expected|
  match do |actual|
    @actual = actual.association_names

    expect(actual.association_names).to include expected
  end
end
