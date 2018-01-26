require_relative 'session'

module Ufebs
  module Entities
    class ProcessingDetails
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      attribute :debit_date, String, tag: 'DebitDate'
      attribute :credit_date, String, tag: 'CreditDate'
      has_one :session, ::Ufebs::Entities::Session, tag: 'Session', state_when_nil: false

      def initialize(debit_date: Time.now, credit_date: Time.now)
        @debit_date = Date.parse(debit_date.to_s).strftime('%Y-%m-%d')
        @credit_date = Date.parse(credit_date.to_s).strftime('%Y-%m-%d')
      end
    end
  end
end
