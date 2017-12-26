require_relative '../entities/bank'
require_relative '../entities/acc_doc'
require_relative '../entities/departmental_info'
require_relative '../entities/participant'

module Ufebs
  module Documents
    class PaymentOrder
      include HappyMapper
      InvalidPriority = Class.new(StandardError)

      DOCUMENT_NUMBER_TYPE = '01'.freeze
      SYSTEM_CODE          = '01'.freeze

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      tag 'ED101'
      namespace 'ed'

      attribute :number, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :sum, String, tag: 'Sum'
      attribute :payt_kind, String, tag: 'PaytKind'
      attribute :type_number, String, tag: 'TransKind'
      attribute :uin, String, tag: 'PaymentID'
      attribute :charge_off_date, String, tag: 'ChargeOffDate'
      attribute :receipt_date, String, tag: 'ReceiptDate'
      attribute :system_code, String, tag: 'SystemCode'
      attribute :priority, String, tag: 'Priority'
      has_one :acc_doc, ::Ufebs::Entities::AccDoc, tag: 'AccDoc'
      has_one :payer, ::Ufebs::Entities::Participant, tag: 'Payer'
      has_one :payee, ::Ufebs::Entities::Participant, tag: 'Payee'
      element :purpose, String, tag: 'Purpose'

      has_one :departmental_info, Ufebs::Entities::DepartmentalInfo, tag: 'DepartmentalInfo', state_when_nil: false

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
        payt_kind: nil,
        system_code: nil,
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

        @ed_author   = ed_author
        @type_number = DOCUMENT_NUMBER_TYPE
        @system_code = system_code || SYSTEM_CODE

        yield self if block_given?

        super()
      end
    end
  end
end
