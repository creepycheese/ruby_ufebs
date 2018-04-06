require_relative 'ed_field_list'
require_relative '../../ufebs/modules/common'

module Ufebs
  module Entities
    class EdReestrInfo
      include HappyMapper
      include Ufebs::Common

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      attribute :transaction_id, String, tag: 'TransactionID'

      has_many :ed_reestr_field_lists,
               Ufebs::Entities::EdFieldList,
               tag: 'EDReestrFieldList'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :ed_reestr_field_lists then set_ed_reestr_field_lists(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def set_ed_reestr_field_lists(value)
        @ed_reestr_field_lists =
          value.map { |params| Ufebs::Entities::EdFieldList.new(to_hash(params)) }
      end
    end
  end
end
