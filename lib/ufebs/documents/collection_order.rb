require_relative 'base_payment'
require_relative '../fields/payment_doc'

module Ufebs
  module Documents
    class CollectionOrder < BasePayment
      include HappyMapper
      include Ufebs::Fields::PaymentDoc

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED104'
      namespace 'ed'

      attribute :receipt_date_collect_bank, String, tag: 'ReceiptDateCollectBank'
      attribute :file_date,                 String, tag: 'FileDate'
    end
  end
end
