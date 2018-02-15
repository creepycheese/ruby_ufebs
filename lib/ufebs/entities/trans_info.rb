require_relative 'ed_ref_id'

module Ufebs
  module Entities
    class TransInfo
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'
      tag 'TransInfo'

      attribute :acc_doc_no,         String, tag: 'AccDocNo'
      attribute :bic_corr,           String, tag: 'BICCorr'
      attribute :dc,                 String, tag: 'DC'
      attribute :payee_personal_acc, String, tag: 'PayeePersonalAcc'
      attribute :payer_personal_acc, String, tag: 'PayerPersonalAcc'
      attribute :sum,                String, tag: 'Sum'
      attribute :trans_kind,         String, tag: 'TransKind'
      attribute :turnover_kind,      String, tag: 'TurnoverKind'
      attribute :cash_doc_no,        String, tag: 'CashDocNo'

      has_one :ed_ref_id, ::Ufebs::Entities::EdRefId

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :ed_ref_id then @ed_ref_id = Ufebs::Entities::EdRefId.new(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
