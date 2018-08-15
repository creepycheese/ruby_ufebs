module Ufebs
  module Fields
    module PaymentDoc
      def self.included(content)
        content.attribute :number, String, tag: 'EDNo'
        content.attribute :ed_date, String, tag: 'EDDate'
        content.attribute :ed_author, String, tag: 'EDAuthor'
        content.attribute :sum, String, tag: 'Sum'
        content.attribute :payt_kind, String, tag: 'PaytKind'
        content.attribute :type_number, String, tag: 'TransKind'
        content.attribute :uin, String, tag: 'PaymentID'
        content.attribute :charge_off_date, String, tag: 'ChargeOffDate'
        content.attribute :receipt_date, String, tag: 'ReceiptDate'
        content.attribute :system_code, String, tag: 'SystemCode'
        content.attribute :priority, String, tag: 'Priority'
        content.attribute :payment_precedence, String, tag: 'PaymentPrecedence'
        content.has_one :acc_doc, ::Ufebs::Entities::AccDoc, tag: 'AccDoc'
        content.has_one :payer, ::Ufebs::Entities::Participant, tag: 'Payer'
        content.has_one :payee, ::Ufebs::Entities::Participant, tag: 'Payee'
        content.element :purpose, String, tag: 'Purpose'

        content.has_one :processing_details, ::Ufebs::Entities::ProcessingDetails, tag: 'ProcessingDetails', state_when_nil: false
        content.has_one :departmental_info, Ufebs::Entities::DepartmentalInfo, tag: 'DepartmentalInfo', state_when_nil: false
      end
    end
  end
end
