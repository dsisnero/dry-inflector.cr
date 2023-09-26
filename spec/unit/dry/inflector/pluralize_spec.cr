# frozen_string_literal: true

require "../../../spec_helper"

describe Dry::Inflector do
  describe "#pluralize" do
    Fixtures::Pluralize.cases.each do |singular, plural|
      it "pluralizes #{singular} => #{plural}" do
        Dry::Inflector.new.pluralize(singular).should eq(plural)
      end
    end

    Fixtures::Pluralize.irregular.each do |singular, plural|
      it "(irregular) pluralizes#{singular} => #{plural}" do
        Dry::Inflector.new.pluralize(singular).should eq(plural)
      end
    end

    Fixtures::Pluralize.pending.each do |singular, plural|
      pending "missing exception or rule for #{singular} => #{plural}"

      it "fails as expected since it's 'pending' (tip: remove it from pending!)" do
        Dry::Inflector.new.singularize(singular).should_not eq(plural)
      end
    end

    it "accepts symbols" do
      Dry::Inflector.new.pluralize(:user).should eq("users")
      Dry::Inflector.new.pluralize(:money).should eq("money")
    end

    context "with custom inflection rules" do
      subject = Dry::Inflector.new do |inflections|
        inflections.plural "virus", "viruses"
        inflections.irregular "plus", "plusses"
        inflections.uncountable "dry-inflector"
      end

      it "pluralizes using '#plural' rule" do
        subject.pluralize("virus").should eq("viruses")
      end

      it "pluralizes using '#irregular' rule" do
        subject.pluralize("plus").should eq("plusses")
      end

      it "doesn't pluralize uncountable" do
        subject.pluralize("dry-inflector").should eq("dry-inflector")
      end
    end
  end
end
