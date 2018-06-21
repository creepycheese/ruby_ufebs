module Ufebs
  class SchemaValidationResult
    attr_reader :errors

    def initialize(errors)
      @errors = errors
    end

    def valid?
      errors.empty?
    end
  end
end
