# frozen_string_literal: true

module Ufebs
  module Entities
    class BicAccount
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      attribute :bic, String, tag: 'BIC'
      attribute :correspondent_account, String, tag: 'CorrespAcc'

      def initialize(bic: '', correspondent_account: '')
        @bic = bic
        @correspondent_account = correspondent_account
      end
    end
  end
end
