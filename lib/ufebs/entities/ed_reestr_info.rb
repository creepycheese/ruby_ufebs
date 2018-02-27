module Ufebs
  module Entities
    class EdReestrInfo
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      attribute :transaction_id, String, tag: 'TransactionID'

      has_many :ed_reestr_filed_lists,
               Ufebs::Entities::EdFieldList,
               tag: 'EDReestrFieldList'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :ed_reestr_filed_lists then set_ed_reestr_filed_lists(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def set_ed_reestr_filed_lists(value)
        @ed_reestr_filed_lists =
          value.map { |params| Ufebs::Entities::EdFieldList.new(params) }
      end
    end
  end
end
