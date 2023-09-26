# frozen_string_literal: true

require "../../../spec_helper"

describe Dry::Inflector do
  describe "#camelize_lower" do
    Fixtures::CamelizeLower.cases.each do |input, camelized|
      it "lower camelizes #{input} => #{camelized}" do
        Dry::Inflector.new.camelize_lower(input).should eq(camelized)
      end
    end

    Fixtures::CamelizeLower.pending.each do |input, camelized|
      pending "missing exception or rule for #{input} => #{camelized}"
    end

    it "accepts symbols" do
      Dry::Inflector.new.camelize_lower(:data_mapper).should eq("dataMapper")
    end

    it "handles acronyms" do
      Dry::Inflector.new.camelize_lower("json").should eq("JSON")
      Dry::Inflector.new.camelize_lower("http_error").should eq("HTTPError")
      Dry::Inflector.new.camelize_lower("openssl/hmac").should eq("OpenSSL::HMAC")
      Dry::Inflector.new.camelize_lower("openssl/digest").should eq("OpenSSL::Digest")
    end

    context "custom acronyms" do
      it "handles acronyms" do
        subject = Dry::Inflector.new do |inflect|
          inflect.acronym(%w[IP HTML XML BSD])
        end
        subject.camelize_lower("ip").should eq("IP")
        subject.camelize_lower("ip_sec").should eq("IPSec")
        subject.camelize_lower("html_tidy").should eq("HTMLTidy")
        subject.camelize_lower("html_tidy_generator").should eq("HTMLTidyGenerator")
        subject.camelize_lower("force_xml_controller").should eq("forceXMLController")
        subject.camelize_lower("free_bsd").should eq("freeBSD")
      end
    end
  end
end
