# frozen_string_literal: true

require "../../../spec_helper"

describe Dry::Inflector do
  describe "#singularize" do
    Fixtures::Singularize.cases.each do |plural, singular|
      it "singularizes #{plural} => #{singular}" do
        Dry::Inflector.new.singularize(plural).should eq(singular)
      end
      it "singularizes test_#{plural} => test_#{singular}" do
        Dry::Inflector.new.singularize("test_#{plural}").should eq("test_#{singular}")
      end
      it "singularizes test-#{plural} => test-#{singular}" do
        Dry::Inflector.new.singularize("test-#{plural}").should eq("test-#{singular}")
      end
      it "singularizes 'test #{plural}' => 'test #{singular}'" do
        Dry::Inflector.new.singularize("test #{plural}").should eq("test #{singular}")
      end
    end

    Fixtures::Singularize.pending.each do |plural, singular|
      pending "missing exception or rule for #{plural} => #{singular}"

      it "fails as expected since it's 'pending' (tip: remove it from pending!)" do
        Dry::Inflector.new.singularize(plural).should_not eq(singular)
      end
    end

    it "accepts symbols" do
      Dry::Inflector.new.singularize(:users).should eq("user")
      Dry::Inflector.new.singularize(:money).should eq("money")
    end

    context "with custom inflection rules" do
      subject = Dry::Inflector.new do |inflections|
        inflections.singular "viruses", "virus"
        inflections.irregular "plus", "plusses"
        inflections.uncountable "dry-inflector"
      end

      it "pluralizes using '#singular' rule" do
        subject.singularize("viruses").should eq("virus")
      end
      it "pluralizes using '#irregular' rule" do
        subject.singularize("plusses").should eq("plus")
      end
      it "doesn't singularize uncountable" do
        subject.singularize("dry-inflector").should eq("dry-inflector")
      end
    end
  end
end
