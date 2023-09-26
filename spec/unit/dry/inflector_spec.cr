# frozen_string_literal: true

describe Dry::Inflector do
  describe "#to_s" do
    Dry::Inflector.new.to_s.should eq("#<Dry::Inflector>")
  end

  describe "#inspect" do
    inflector = Dry::Inflector.new
    inflector.inspect.should eq(inflector.to_s)
  end
end
