require_relative 'base_payment'
require_relative '../fields/payment_doc'

module Ufebs
  module Documents
    class BankOrder < BasePayment
      include HappyMapper
      include Ufebs::Fields::PaymentDoc

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      tag 'ED104'
      namespace 'ed'
    end
  end
end
