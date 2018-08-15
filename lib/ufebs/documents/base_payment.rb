require_relative '../entities/bank'
require_relative '../entities/acc_doc'
require_relative '../entities/departmental_info'
require_relative '../entities/participant'

module Ufebs
  module Documents
    class BasePayment
      include HappyMapper
      DOCUMENT_NUMBER_TYPE = '06'.freeze
      SYSTEM_CODE          = '02'.freeze

      def validate
        Ufebs.validate(to_xml)
      end

      def as_xml(encoding: 'UTF-8')
        to_xml(Nokogiri::XML::Builder.new(:encoding => encoding)).to_xml
      end

      def initialize(
        ed_date: Time.now,
        number: nil,
        sum: nil,
        charge_off_date: Time.now,
        priority: 0,
        receipt_date: Time.now,
        ed_author: '',
        acc_doc: nil,
        payer: nil,
        payee: nil,
        purpose: '',
        uin: nil,
        trans_kind: DOCUMENT_NUMBER_TYPE,
        payt_kind: nil,
        system_code: nil,
        payment_precedence: nil,
        processing_details: nil,
        departmental_info: nil
      )
        raise InvalidPriority.new('priority Реквизит должен иметь значение в диапазоне 0-5.') unless (0..5).include?(priority.to_i)

        @ed_date         = Date.parse(ed_date.to_s).strftime('%Y-%m-%d')
        @number          = number
        @sum             = sum
        @charge_off_date = Date.parse(charge_off_date.to_s).strftime('%Y-%m-%d')
        @receipt_date    = Date.parse(receipt_date.to_s).strftime('%Y-%m-%d')
        @priority        = priority
        @acc_doc         = acc_doc.is_a?(Hash) ? Ufebs::Entities::AccDoc.new(acc_doc) : acc_doc
        @payer           = payer.is_a?(Hash) ? Ufebs::Entities::Participant.new(payer) : payer
        @payee           = payer.is_a?(Hash) ? Ufebs::Entities::Participant.new(payee) : payee
        @purpose         = purpose
        @departmental_info = departmental_info.is_a?(Hash) ? Ufebs::Entities::DepartmentalInfo.new(departmental_info) : departmental_info
        @uin            = uin
        @payt_kind      = payt_kind

        @payment_precedence = payment_precedence
        @processing_details = processing_details.is_a?(Hash) ? ::Ufebs::Entities::ProcessingDetails.new(processing_details) : processing_details

        @ed_author   = ed_author
        @type_number = trans_kind
        @system_code = system_code || SYSTEM_CODE

        yield self if block_given?

        super()
      end
    end
  end
end
