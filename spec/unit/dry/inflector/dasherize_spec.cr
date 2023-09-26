# frozen_string_literal: true
require "../../../spec_helper"

describe Dry::Inflector do
  describe "#dasherize" do
    it "dasherizes data_mapper_rspec as data-mapper-rspec" do
      Dry::Inflector.new.dasherize("data_mapper_rspec").should eq("data-mapper-rspec")
    end

    it "accepts symbols" do
      Dry::Inflector.new.dasherize(:data_mapper_rspec).should eq("data-mapper-rspec")
    end
  end
end
