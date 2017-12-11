require 'happymapper'
require "ufebs/version"
require "ufebs/configuration"
Dir[File.dirname(__FILE__) + '/**/*.rb'].each { |ff| require ff }

module Ufebs
  extend self

  XMLNS="urn:cbr-ru:ed:v2.0".freeze

  def configuration
    @configuration ||= Configuration.new
  end

  def configure(&block)
    block.call(configuration)
  end

  def validation_schema
    @validation ||= begin
                      validation = Nokogiri::XML(File.read(configuration.schemas), configuration.schemas)
                      Nokogiri::XML::Schema.from_document(validation)
                    end
  end

  def ED999(params)
    Ufebs::Requests::TestRequest.new(params)
  end

  def ED101(params)
    Ufebs::Documents::PaymentOrder.new(params)
  end

  def PackedEPD()
  end

  def validate(doc)
    doc = Nokogiri::XML(doc) if doc.is_a?(String)

    errors = []
    validation_schema.validate(doc).each do |error|
      errors << error.message
      puts error.message
    end
    errors.empty?
  end
end
