module Ufebs
  module Entities
    class ParticipantId
      include HappyMapper
      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      element :bic, String, tag: 'BIC'

      def initialize(bic: '')
        @bic = bic
      end
    end
  end
end
