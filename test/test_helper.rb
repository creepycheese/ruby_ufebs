$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ufebs'

Ufebs.configure do |config|
  config.standard = '2020'
end

XML_VALIDATION = Ufebs.validation_schema
require 'minitest/autorun'
