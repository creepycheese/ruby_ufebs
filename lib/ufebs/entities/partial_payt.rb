require_relative 'acc_doc'

module Ufebs
  module Entities
    class PartialPayt
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'
      tag 'PartialPayt'

      attribute :payt_no,           String, tag: 'PaytNo'
      attribute :trans_kind,        String, tag: 'TransKind'
      attribute :sum_residual_payt, String, tag: 'SumResidualPayt'

      has_one :acc_doc, ::Ufebs::Entities::AccDoc, tag: 'AccDoc'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :acc_doc then set_acc_doc(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def set_acc_doc(value)
        @acc_doc = value.is_a?(Hash) ? ::Ufebs::Entities::AccDoc.new(value) : value
      end
    end
  end
end
