require_relative '../entities/bank'
require_relative '../entities/acc_doc'
require_relative '../entities/departmental_info'
require_relative '../entities/participant'

module Ufebs
  module Documents
    class BasePayment
      include HappyMapper
      DOCUMENT_TRANS_KIND = '06'.freeze
      SYSTEM_CODE         = '02'.freeze

      def validate
        Ufebs.validate(to_xml)
      end

      def as_xml(encoding: 'UTF-8')
        to_xml(Nokogiri::XML::Builder.new(:encoding => encoding)).to_xml
      end

      def initialize(params = {})
        params = {
          ed_date:         Time.now,
          charge_off_date: Time.now,
          priority:        0,
          receipt_date:    Time.now,
          ed_author:       '',
          purpose:         '',
          trans_kind:      DOCUMENT_TRANS_KIND,
          system_code:     SYSTEM_CODE
        }.merge(params)

        validate_priority(params[:priority])

        params.each do |key, value|
          case key.to_sym
          when :ed_date             then @ed_date             = Date.parse(value.to_s).strftime('%Y-%m-%d')
          when :charge_off_date     then @charge_off_date     = Date.parse(value.to_s).strftime('%Y-%m-%d')
          when :receipt_date        then @receipt_date        = Date.parse(value.to_s).strftime('%Y-%m-%d')
          when :acc_doc             then @acc_doc             = value.is_a?(Hash) ? Ufebs::Entities::AccDoc.new(value) : value
          when :payer               then @payer               = value.is_a?(Hash) ? Ufebs::Entities::Participant.new(value) : value
          when :payee               then @payee               = value.is_a?(Hash) ? Ufebs::Entities::Participant.new(value) : value
          when :partial_payt        then @partial_payt        = value.is_a?(Hash) ? Ufebs::Entities::PartialPayt.new(value) : value
          when :departmental_info   then @departmental_info   = value.is_a?(Hash) ? Ufebs::Entities::DepartmentalInfo.new(value) : value
          when :processing_details  then @processing_details  = value.is_a?(Hash) ? Ufebs::Entities::ProcessingDetails.new(value) : value
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end

        yield self if block_given?

        super()
      end

      protected

      def validate_priority(priority)
        return if (0..5).include?(priority.to_i)
        raise InvalidPriority.new('priority Реквизит должен иметь значение в диапазоне 0-5.')
      end
    end
  end
end
