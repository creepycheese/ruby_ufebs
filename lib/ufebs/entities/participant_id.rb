# frozen_string_literal: true

module Ufebs
  module Entities
    class ParticipantId
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      element :bic, String, tag: 'BIC'
      element :uid, String, tag: 'UID'

      def initialize(bic: '', uid: '')
        @bic = bic
        @uid = uid
      end
    end
  end
end
