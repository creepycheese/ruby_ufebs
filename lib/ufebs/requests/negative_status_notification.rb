require_relative '../entities/ed_ref_id'

module Ufebs
  module Requests
    class NegativeStatusNotification
      include HappyMapper
      include Ufebs::Fields::Header

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED201'
      namespace 'ed'

      attribute :ctrl_code,  String, tag: 'CtrlCode'
      attribute :ctrl_time,  String, tag: 'CtrlTime'
      element   :annotation, String, tag: 'Annotation'

      has_one :ed_ref_id, ::Ufebs::Entities::EdRefId

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :ed_ref_id then @ed_ref_id = Ufebs::Entities::EdRefId.new(value)
          when :ctrl_time then @ctrl_time = DateTime.parse(value.to_s).strftime('%Y-%m-%dT%H:%M:%SZ')
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
