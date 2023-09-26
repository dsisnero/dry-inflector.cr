# frozen_string_literal: true

require "../../../spec_helper"

describe Dry::Inflector do
  describe "#tableize" do
    it "pluralizes last word in snake_case strings: fancy_category => fancy_categories" do
      Dry::Inflector.new.tableize("fancy_category").should eq("fancy_categories")
    end

    it "underscores CamelCase strings before pluralization: enlarged_testis => enlarged_testes" do
      Dry::Inflector.new.tableize("enlarged_testis").should eq("enlarged_testes")
    end

    it "underscores CamelCase strings before pluralization: FancyCategory => fancy_categories" do
      Dry::Inflector.new.tableize("FancyCategory").should eq("fancy_categories")
    end

    it "underscores CamelCase strings before pluralization: EnlargedTestis => enlarged_testes" do
      Dry::Inflector.new.tableize("EnlargedTestis").should eq("enlarged_testes")
    end

    it "replaces :: with underscores: My::Fancy::Category => my_fancy_categories" do
      Dry::Inflector.new.tableize("My::Fancy::Category").should eq("my_fancy_categories")
    end

    it "underscores CamelCase strings before pluralization: Enlarged::Testis => enlarged_testes" do
      Dry::Inflector.new.tableize("Enlarged::Testis").should eq("enlarged_testes")
    end

    it "accepts symbols" do
      Dry::Inflector.new.tableize(:fancy_category).should eq("fancy_categories")
    end
  end
end
