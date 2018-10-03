require_relative '../entities/acc_doc'
require_relative '../entities/departmental_info'
require_relative '../entities/participant'
require_relative './base_payment'

module Ufebs
  module Documents
    class PaymentOrder < BasePayment
      include HappyMapper
      include Ufebs::Fields::PaymentDoc

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED101'
      namespace 'ed'
    end
  end
end
