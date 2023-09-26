# frozen_string_literal: true

require "../../../spec_helper"
describe Dry::Inflector do
  describe "#underscore" do
    it "underscores DataMapper as data_mapper" do
      Dry::Inflector.new.underscore("DataMapper").should eq("data_mapper")
    end

    it "underscores Merb as merb" do
      Dry::Inflector.new.underscore("Merb").should eq("merb")
    end

    it "underscores DataMapper::Resource as data_mapper/resource" do
      Dry::Inflector.new.underscore("DataMapper::Resource").should eq("data_mapper/resource")
    end

    it "underscores Merb::BootLoader::Rackup as merb/boot_loader/rackup" do
      Dry::Inflector.new.underscore("Merb::BootLoader::Rackup").should eq("merb/boot_loader/rackup")
    end

    it "underscores data-mapper as data_mapper" do
      Dry::Inflector.new.underscore("data-mapper").should eq("data_mapper")
    end

    it "underscores CLI as cli" do
      Dry::Inflector.new.underscore("CLI").should eq("cli")
    end

    it "underscores castleKing as castle_king" do
      Dry::Inflector.new.underscore("castleKing").should eq("castle_king")
    end

    it "underscores CLIRunner as cli_runner" do
      Dry::Inflector.new.underscore("CLIRunner").should eq("cli_runner")
    end

    it "accepts symbols" do
      Dry::Inflector.new.underscore(:DataMapper).should eq("data_mapper")
    end

    it "handles acronyms" do
      Dry::Inflector.new.underscore("JSON").should eq("json")
      Dry::Inflector.new.underscore("HTTPError").should eq("http_error")
      Dry::Inflector.new.underscore("OpenSSL::HMAC").should eq("openssl/hmac")
      Dry::Inflector.new.underscore("OpenSSL::Digest").should eq("openssl/digest")
    end
  end
end
