module Ufebs
  module Entities
    class DepartmentalInfo
      include HappyMapper
      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      attribute :kbk,           String, tag: 'CBC'
      attribute :okato,         String, tag: 'OKATO'
      attribute :tax_period,    String, tag: 'TaxPeriod'
      attribute :drawer_status, String, tag: 'DrawerStatus'
      attribute :payt_reason,   String, tag: 'PaytReason'
      attribute :doc_no,        String, tag: 'DocNo'
      attribute :tax_payt_kind, String, tag: 'TaxPaytKind'
      attribute :doc_date,      String, tag: 'DocDate'

      def initialize(
        tax_payt_kind: 'HC',
        doc_date: Time.now,
        doc_no: '',
        payt_reason: '',
        drawer_status: '01',
        tax_period: '',
        okato: '',
        kbk: ''
      )

        @tax_payt_kind = tax_payt_kind
        @doc_date = doc_date == '0' ? '0' : Date.parse(doc_date.to_s).strftime('%d.%m.%Y')
        @doc_no = doc_no
        @payt_reason = payt_reason
        @drawer_status = drawer_status
        @tax_period = tax_period
        @okato = okato
        @kbk = kbk
      end
    end
  end
end
