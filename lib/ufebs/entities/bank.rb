module Ufebs
  module Entities
    class Bank
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      attribute :bic, String, tag: 'BIC'
      attribute :account, String, tag: 'CorrespAcc'

      def initialize(bic: '', account: '')
        @bic, @account = bic, account
      end
    end
  end
end
