module Ufebs
  module Entities
    class EdDefineAnswerInfo
      include HappyMapper

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      attribute :payer_long_name,       String, tag: 'PayerLongName'
      attribute :payee_long_name,       String, tag: 'PayeeLongName'
      attribute :purpose,               String, tag: 'Purpose'
      attribute :address,               String, tag: 'Address'
      attribute :ed_define_answer_text, String, tag: 'EDDefineAnswerText'

      has_many :ed_filed_lists,
               Ufebs::Entities::EdFieldList,
               tag: 'EDFieldList'

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
