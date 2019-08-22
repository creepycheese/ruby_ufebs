module Ufebs
  module Entities
    class RequestReason
      include HappyMapper
      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      attribute :reason_code, String, tag: 'CreateReasonCode'

      def initialize(reason_code: '')
        @reason_code = reason_code
      end
    end
  end
end
