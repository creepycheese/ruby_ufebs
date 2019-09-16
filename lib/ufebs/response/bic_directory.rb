# frozen_string_literal: true

module Ufebs
  module Response
    class BicDirectory
      include HappyMapper

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'

      tag 'ED807'
      namespace 'ed'

      has_one :initial_ed, Ufebs::Entities::EdRefId, tag: 'InitialED'

      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'

      attribute :info_type_code, String, tag: 'InfoTypeCode'
      attribute :creation_reason, String, tag: 'CreationReason'

      def creation_reason_codes
        [@creation_reason]
      end
    end
  end
end
