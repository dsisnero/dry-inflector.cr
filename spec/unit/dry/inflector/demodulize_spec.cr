# frozen_string_literal: true
require "../../../spec_helper"

describe Dry::Inflector do
  describe "#demodulize" do
    it "demodulizes module name: DataMapper::Inflecto => Inflecto" do
      Dry::Inflector.new.demodulize("DataMapper::Inflecto").should eq("Inflecto")
    end

    it "demodulizes module name: A::B::C::D::E => E" do
      Dry::Inflector.new.demodulize("A::B::C::D::E").should eq("E")
    end

    it "accepts symbols" do
      Dry::Inflector.new.demodulize(:"DataMapper::Inflecto").should eq("Inflecto")
    end
  end
end
