# frozen_string_literal: true

require "../../../spec_helper"

describe Dry::Inflector do
  describe "#uncountable?" do
    it "returns true when empty string" do
      Dry::Inflector.new.uncountable?("").should be_true
    end

    it "returns true when blank string" do
      Dry::Inflector.new.uncountable?("   ").should be_true
    end

    it "returns true when word is present in list" do
      Dry::Inflector.new.uncountable?("grass").should be_true
    end

    it "returns false when word is not present in list" do
      Dry::Inflector.new.uncountable?("user").should be_false
    end

    it "returns true when word is present in list but in different case" do
      Dry::Inflector.new.uncountable?("FiSH").should be_true
    end
  end
end
