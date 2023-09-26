# frozen_string_literal: true

require "../../../spec_helper"
describe Dry::Inflector do
  describe "#camelize_upper" do
    Fixtures::CamelizeUpper.cases.each do |input, camelized|
      it "upper camelizes #{input} => #{camelized}" do
        Dry::Inflector.new.camelize_upper(input).should eq(camelized)
      end
    end

    # Fixtures::CamelizeUpper.pending.each do |input, camelized|
    #   pending "missing exception or rule for #{input} => #{camelized}"
    # end

    it "accepts symbols" do
      Dry::Inflector.new.camelize_upper(:data_mapper).should eq("DataMapper")
    end

    it "have alias" do
      Dry::Inflector.new.camelize("camelize_upper").should eq("CamelizeUpper")
    end

    it "handles acronyms" do
      subject = Dry::Inflector.new
      subject.camelize_upper("json").should eq("JSON")
      subject.camelize_upper("http_error").should eq("HTTPError")
      subject.camelize_upper("openssl/hmac").should eq("OpenSSL::HMAC")
      subject.camelize_upper("openssl/digest").should eq("OpenSSL::Digest")
    end

    context "custom acronyms" do

      # it "handles acronyms" do
      #   subject = Dry::Inflector.new do |inflect|
      #     inflect.acronym("IP", "HTML", "XML", "BSD")
      #   end
      #   subject.camelize_upper("ip").should eq("IP")
      #   subject.camelize_upper("ip_sec").should eq("IPSec")
      #   subject.camelize_upper("html_tidy").should eq("HTMLTidy")
      #   subject.camelize_upper("html_tidy_generator").should eq("HTMLTidyGenerator")
      #   subject.camelize_upper("force_xml_controller").should eq("ForceXMLController")
      #   subject.camelize_upper("free_bsd").should eq("FreeBSD")
      # end
    end
  end
end
