require_relative 'base_payment'
require_relative '../fields/payment_doc'

module Ufebs
  module Documents
    class PayerOrder < BasePayment
      include HappyMapper

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED105'
      namespace 'ed'

      attribute :number,             String, tag: 'EDNo'
      attribute :ed_date,            String, tag: 'EDDate'
      attribute :ed_author,          String, tag: 'EDAuthor'
      attribute :sum,                String, tag: 'Sum'
      attribute :payt_kind,          String, tag: 'PaytKind'
      attribute :trans_kind,         String, tag: 'TransKind'
      attribute :uin,                String, tag: 'PaymentID'
      attribute :system_code,        String, tag: 'SystemCode'
      attribute :priority,           String, tag: 'Priority'
      attribute :payment_precedence, String, tag: 'PaymentPrecedence'
      attribute :trans_content,      String, tag: 'TransContent'

      element :purpose, String, tag: 'Purpose'

      has_one :acc_doc,            ::Ufebs::Entities::AccDoc,            tag: 'AccDoc'
      has_one :payer,              ::Ufebs::Entities::Participant,       tag: 'Payer'
      has_one :payee,              ::Ufebs::Entities::Participant,       tag: 'Payee'
      has_one :partial_payt,       ::Ufebs::Entities::PartialPayt,       tag: 'PartialPayt'
      has_one :processing_details, ::Ufebs::Entities::ProcessingDetails, tag: 'ProcessingDetails', state_when_nil: false
      has_one :departmental_info,  ::Ufebs::Entities::DepartmentalInfo,  tag: 'DepartmentalInfo',  state_when_nil: false
    end
  end
end
