module Ufebs
  module Entities
    class EdDefineRequestInfo
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      attribute :acc_doc_date, String, tag: 'AccDocDate'
      attribute :acc_doc_no,   String, tag: 'AccDocNo'
      attribute :payer_acc,    String, tag: 'PayerAcc'
      attribute :payee_acc,    String, tag: 'PayeeAcc'
      attribute :sum,          String, tag: 'Sum'

      has_many :ed_filed_lists,
               Ufebs::Entities::EdFieldList,
               tag: 'EdFieldList'

      has_many :ed_define_reestr_infos,
               Ufebs::Entities::EdReestrInfo,
               tag: 'EDReestrInfo'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :ed_filed_lists         then @ed_filed_lists         = set_ed_filed_lists(value)
          when :ed_define_reestr_infos then @ed_define_reestr_infos = set_ed_define_reestr_infos(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def set_ed_filed_lists(value)
        value.map { |params| Ufebs::Entities::EdFieldList.new(params) }
      end

      def set_ed_define_reestr_infos(value)
        value.map { |params| Ufebs::Entities::EdReestrInfo.new(params) }
      end
    end
  end
end