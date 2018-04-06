module Ufebs
  module Entities
    class EdFieldList
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      has_many :field_no,    String, tag: 'FieldNo'
      element  :field_value, String, tag: 'FieldValue'

      def initialize(params = {})
        params.each do |key, value|
          instance_variable_set("@#{key}".to_sym, value)
        end
      end
    end
  end
end
