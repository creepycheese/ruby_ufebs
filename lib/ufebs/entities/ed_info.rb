require_relative 'ed_ref_id'

module Ufebs
  module Entities
    class EdInfo
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'
      tag 'EDInfo'

      attribute :sum, String, tag: 'Sum'

      has_one :ed_ref_id,
              ::Ufebs::Entities::EdRefId

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
