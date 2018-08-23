require_relative 'base_payment'
require_relative '../fields/payment_doc'

module Ufebs
  module Documents
    class PaymentOrderEd108 < BasePayment
      include HappyMapper
      include Ufebs::Fields::PaymentDoc

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      tag 'ED108'
      namespace 'ed'
    end
  end
end
