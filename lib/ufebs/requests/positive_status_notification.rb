require_relative '../entities/ed_ref_id'

module Ufebs
  module Requests
    class PositiveStatusNotification
      include HappyMapper
      include Ufebs::Fields::Header

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED208'
      namespace 'ed'

      attribute :result_code, String, tag: 'ResultCode'
      attribute :ctrl_code,   String, tag: 'CtrlCode'
      element   :annotation,  String, tag: 'Annotation'

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
