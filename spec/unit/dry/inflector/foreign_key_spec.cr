# frozen_string_literal: true
require "../../../spec_helper"

describe Dry::Inflector do
  describe "#foreign_key" do
    it "adds _id to downcased string: Message => message_id" do
      Dry::Inflector.new.foreign_key("Message").should eq "message_id"
    end

    it "demodulizes string first: Admin::Post => post_id" do
      Dry::Inflector.new.foreign_key("Admin::Post").should eq "post_id"
    end

    it "accepts symbols" do
      Dry::Inflector.new.foreign_key(:message).should eq "message_id"
    end
  end
end
