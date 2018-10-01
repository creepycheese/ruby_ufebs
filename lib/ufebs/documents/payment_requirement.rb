require_relative 'base_payment'
require_relative '../fields/payment_doc'

module Ufebs
  module Documents
    class PaymentRequirement < BasePayment
      include HappyMapper
      include Ufebs::Fields::PaymentDoc

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      tag 'ED103'
      namespace 'ed'

      attribute :receipt_date_collect_bank, String, tag: 'ReceiptDateCollectBank'
      attribute :file_date,                 String, tag: 'FileDate'
      attribute :payt_condition,            String, tag: 'PaytCondition'
      attribute :acpt_term,                 String, tag: 'AcptTerm'
      attribute :doc_dispatch_date,         String, tag: 'DocDispatchDate'
      attribute :maturity_date,             String, tag: 'MaturityDate'
    end
  end
end
