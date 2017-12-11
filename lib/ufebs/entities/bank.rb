module Ufebs
  module Entities
    class Bank
      include HappyMapper

      attribute :bic, String, tag: 'BIC'
      attribute :account, String, tag: 'CorrespAcc'

      def initialize(bic: '', account: '')
        @bic, @account = bic, account
      end
    end
  end
end
