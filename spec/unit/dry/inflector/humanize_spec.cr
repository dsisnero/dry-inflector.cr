# frozen_string_literal: true

require "../../../spec_helper"

describe Dry::Inflector do
  describe "#humanize" do
    it "replaces _ with space: humanizes employee_salary as Employee salary" do
      Dry::Inflector.new.humanize("employee_salary").should eq("Employee salary")
    end

    it "strips _id endings: humanizes author_id as Author" do
      Dry::Inflector.new.humanize("author_id").should eq("Author")
    end

    it "uses user added rules when possible" do
      subject = Dry::Inflector.new do |inflect|
        inflect.human("Question", "Fancy question")
        inflect.human("questionary", "Questionnaire")
      end

      subject.humanize("questionary").should eq("Questionnaire")
    end

    it "accepts symbols" do
      Dry::Inflector.new.humanize(:employee_salary).should eq("Employee salary")
    end

    it "handles acronyms" do
      Dry::Inflector.new.humanize("json").should eq("JSON")
      Dry::Inflector.new.humanize("http_error").should eq("HTTP error")
      Dry::Inflector.new.humanize("openssl/hmac").should eq("OpenSSL/HMAC")
      Dry::Inflector.new.humanize("openssl/digest").should eq("OpenSSL/digest")
    end
  end
end
