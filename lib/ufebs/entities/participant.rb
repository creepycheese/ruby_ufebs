require_relative 'bank'

module Ufebs
  module Entities
    class Participant
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      attribute :inn, String, tag: 'INN'
      attribute :account, String, tag: 'PersonalAcc'
      attribute :kpp, String, tag: 'KPP'

      element   :name, String, tag: 'Name'
      has_one   :bank, Ufebs::Entities::Bank, tag: 'Bank'

      def initialize(inn:'', account:'' ,name:'', bank_account:'', bank_bic:'', kpp: nil)
        @inn, @kpp, @account, @name = inn, kpp, account, name
        @bank = Ufebs::Entities::Bank.new(bic: bank_bic, account: bank_account)
      end
    end
  end
end
