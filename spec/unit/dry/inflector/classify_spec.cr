# frozen_string_literal: true
require "../../../spec_helper"

describe Dry::Inflector do
  describe "#classify" do
    it "classifies data_mapper as DataMapper" do
      Dry::Inflector.new.classify("data_mapper").should eq("DataMapper")
    end

    it "classifies data.mapper as Mapper" do
      Dry::Inflector.new.classify("data.mapper").should eq("Mapper")
    end

    it "classifies enlarged_testes as EnlargedTestis" do
      Dry::Inflector.new.classify("enlarged_testes").should eq("EnlargedTestis")
    end

    it "singularizes string first: classifies data_mappers as egg_and_hams as EggAndHam" do
      Dry::Inflector.new.classify("egg_and_hams").should eq("EggAndHam")
    end

    it "accepts symbols" do
      Dry::Inflector.new.classify(:data_mapper).should eq("DataMapper")
    end
  end
end
