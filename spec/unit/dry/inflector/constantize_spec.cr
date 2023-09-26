# frozen_string_literal: true

require "../../../spec_helper"

module FooA
  class Bar
    VAL = 10
  end

  class Baz < Bar; end
end

module FooB
  class Bar
    def self.const_missing(name)
      name.to_s == "Const" ? Baz : super
    end
  end

  class Baz < Bar; end

  def self.const_missing(name)
    name.to_s == "Autoloaded" ? Bar : super
  end
end

describe Dry::Inflector do
  describe "#constantize" do
    pending "constantize not ready" do
      it "constantizes Module" do
        Dry::Inflector.new.constantize("Module").should eq Module
      end

      it "constantizes ::Module" do
        Dry::Inflector.new.constantize("::Module").should eq Module
      end

      it "accepts symbols" do
        Dry::Inflector.new.constantize(:Module).should eq Module
      end

      it "constantizes nested constant Dry::Inflector::Inflections" do
        Dry::Inflector.new.constantize("Dry::Inflector::Inflections").should eq Dry::Inflector::Inflections
      end

      it "does not search ancestors" do
        Dry::Inflector.new.constantize("FooA::Bar::VAL").should eq(10)
        expect_raises(Exception) { Dry::Inflector.new.constantize("Foo::Baz::VAL") }
      end

      it "searches in const_missing" do
        Dry::Inflector.new.constantize("FooB::Autoloaded::Const").should eq Foo::Baz
        Dry::Inflector.new.constantize("FooB::Bar::Const").should eq Foo::Baz
      end

      it "raises exception when empty string given" do
        expect_raises(Exception) do
          Dry::Inflector.new.constantize("")
        end
      end

      it "raises exception when constant not found" do
        expect_raises(Exception) do
          Dry::Inflector.new.constantize("Qwerty")
        end
      end
    end
  end
end
