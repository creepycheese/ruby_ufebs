module Ufebs
  module Entities
    class Participant
      include HappyMapper

      attribute :inn, String, tag: 'INN'
      attribute :account, String, tag: 'PersonalAcc'
      attribute :kpp, String, tag: 'KPP'

      element   :name, String, tag: 'Name'
      has_one   :bank, Bank, tag: 'Bank'

      def initialize(inn:'', account:'' ,name:'', bank_account:'', bank_bic:'', kpp: nil)
        @inn, @kpp, @account, @name = inn, kpp, account, name.encode(xml: :text)
        @bank = Bank.new(bic: bank_bic, account: bank_account)
      end
    end
  end
end
