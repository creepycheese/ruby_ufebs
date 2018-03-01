require_relative 'ed_field_list'
require_relative 'ed_reestr_info'

module Ufebs
  module Entities
    class EdDefineAnswerInfo
      include HappyMapper

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      attribute :acc_doc_date,   String, tag: 'AccDocDate'
      attribute :acc_doc_no,     String, tag: 'AccDocNo'
      attribute :payer_acc,      String, tag: 'PayerAcc'
      attribute :payee_acc,      String, tag: 'PayeeAcc'
      attribute :payer_inn,      String, tag: 'PayerINN'
      attribute :payee_inn,      String, tag: 'PayeeINN'
      attribute :sum,            String, tag: 'Sum'
      attribute :enter_date,     String, tag: 'EnterDate'
      attribute :payee_corr_acc, String, tag: 'PayeeCorrAcc'
      attribute :payee_bic,      String, tag: 'PayeeBIC'

      element :payer_long_name,       String, tag: 'PayerLongName'
      element :payee_long_name,       String, tag: 'PayeeLongName'
      element :purpose,               String, tag: 'Purpose'
      element :address,               String, tag: 'Address'
      element :ed_define_answer_text, String, tag: 'EDDefineAnswerText'

      has_many :ed_field_lists,
               Ufebs::Entities::EdFieldList,
               tag: 'EDFieldList'

      has_many :ed_define_reestr_infos,
               Ufebs::Entities::EdReestrInfo,
               tag: 'EDReestrInfo'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :ed_field_lists         then set_ed_field_lists(value)
          when :ed_define_reestr_infos then set_ed_define_reestr_infos(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def set_ed_field_lists(value)
        @ed_field_lists =
          value.map { |params| Ufebs::Entities::EdFieldList.new(params) }
      end

      def set_ed_define_reestr_infos(value)
        @ed_define_reestr_infos =
          value.map { |params| Ufebs::Entities::EdReestrInfo.new(params) }
      end
    end
  end
end
