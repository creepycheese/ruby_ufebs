module Ufebs
  module Common
    def array_to_hash(params)
      return Hash[*params] if params.is_a?(Array)
      params
    end

    def present?(value)
      value != nil && value != ''
    end
  end
end
