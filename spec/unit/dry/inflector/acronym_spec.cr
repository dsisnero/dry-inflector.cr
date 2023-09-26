# frozen_string_literal: true
require "../../../spec_helper"

describe Dry::Inflector do
  before_all do
    subject = Dry::Inflector.new do |inflect|
      inflect.acronym(%w["RESTful", "RoR", "PhD", "W3C", "SSL", "HTML"])
    end
  end

  describe "acronyms" do
    it "uses acronyms" do
      subject = Dry::Inflector.new do |inflect|
        inflect.acronym(["RESTful", "RoR", "PhD", "W3C", "SSL", "HTML"])
      end
      # These examples were taken from ActiveSupport's test suite
      #  camelize             underscore            humanize
      [
        %w[API api API],
        ["APIController", "api_controller", "API controller"],
        ["Nokogiri::HTML", "nokogiri/html", "Nokogiri/HTML"],
        ["HTTPAPI", "http_api", "HTTP API"],
        ["HTTP::Get", "http/get", "HTTP/get"],
        ["SSLError", "ssl_error", "SSL error"],
        %w[RESTful restful RESTful],
        ["RESTfulController", "restful_controller", "RESTful controller"],
        ["Nested::RESTful", "nested/restful", "Nested/RESTful"],
        ["IHeartW3C", "i_heart_w3c", "I heart W3C"],
        ["PhDRequired", "phd_required", "PhD required"],
        ["IRoRU", "i_ror_u", "I RoR u"],
        ["RESTfulHTTPAPI", "restful_http_api", "RESTful HTTP API"],
        ["HTTP::RESTful", "http/restful", "HTTP/RESTful"],
        ["HTTP::RESTfulAPI", "http/restful_api", "HTTP/RESTful API"],
        ["APIRESTful", "api_restful", "API RESTful"],
        ["CSRF", "csrf", "Cross Site Request Forgery"],

        # misdirection
        %w[Capistrano capistrano Capistrano],
        ["CapiController", "capi_controller", "Capi controller"],
        ["HttpsApis", "https_apis", "Https apis"],
        %w[Html5 html5 Html5],
        %w[Restfully restfully Restfully],
        ["RoRails", "ro_rails", "Ro rails"],
      ].each do |(camel, under, human)|
        subject.camelize(under).should eq(camel)
        subject.camelize(camel).should eq(camel)
        subject.underscore(camel).should eq(under)
        subject.underscore(under).should eq(under)

        subject.humanize(human).should eq(human)
      end
    end
  end
end
