require 'happymapper'
require "ufebs/version"
require "ufebs/configuration"
Dir[File.dirname(__FILE__) + '/**/entities/*.rb'].each { |ff| require ff }
Dir[File.dirname(__FILE__) + '/**/fields/*.rb'].each { |ff| require ff }
Dir[File.dirname(__FILE__) + '/**/documents/*.rb'].each { |ff| require ff }
Dir[File.dirname(__FILE__) + '/**/requests/*.rb'].each { |ff| require ff }

module Ufebs
  extend self

  def namespace
    "urn:cbr-ru:ed:v2.0".freeze
  end

  def configuration
    @configuration ||= Configuration.new
  end

  # Конфигурация
  def configure(&block)
    block.call(configuration)
  end

  def validation_schema
    @validation ||= begin
                      validation = Nokogiri::XML(File.read(configuration.schemas), configuration.schemas)
                      Nokogiri::XML::Schema.from_document(validation)
                    end
  end

  # XML запрос-зонд
  # @param params [Hash]
  # @option :number аттрибут EDNo
  # @option :ed_date аттрибут EDDate
  # @option :ed_author аттрибут EDAuthor
  def ED999(params)
    Ufebs::Requests::TestRequest.new(params)
  end

  def ED210(params)
  end

  def ED243(params)
  end

  def ED218(params)
  end

  def ED244
  end


  # Создание XML по формату ED101(Платежное поручение)
  # @param params [Hash, String] Hash значений документа или его строковое представление в виде XML
  # @option params [Integer] :number номер документа аттрибут EDNo
  # @option params [Integer] :sum Сумма документа аттрибут Sum
  # @option params [DateTime] :receipt_date ReceiptDate дата обработки
  # @option params [Hash] :acc_doc AccDoc информация о счете(number: Номер исходного расчетного документа, date: Дата выписки расчетного документа
  # @option params [String] :purpose Purpose предназначение-описание платежа
  # @option params [Hash] :payer Payer плательщик
  # @option params [Hash] :payer Payee получатель
  # @option params [Hash] :departmental_info ({}) DepartmentalInfo Ведомственная информация
  # @return [Ufebs::Documents::PaymentOrder] Представление документа УФЕБС
  # @example Пример документа
  #   ed101 = Ufebs::ED101(
  #     number: 7,
  #     sum: 150000,
  #     receipt_date: Time.now,
  #     acc_doc: { number: '3', date: Time.now },
  #     ed_author: 4525595000
  #     purpose: 'оплата в том числе ндс 4000 руб',
  #     payer: {
  #       name: 'ООО ТЕСТ',
  #       account: '40702810200203001037',
  #       inn: '7726274727',
  #       bank_bic: '044525545',
  #       bank_account: '30101810300000000545'
  #     },
  #     payee: {
  #       name: 'ООО ТЕСТ',
  #       account: '40702810200203001037',
  #       inn: '7726274727',
  #       bank_bic: '044525545',
  #       bank_account: '30101810300000000545'
  #     },
  #     departmental_info: {
  #       kbk: '18210301000010000110',
  #       okato: '45263591000',
  #       drawer_status: '01',
  #       tax_period: 'МС.03.2017',
  #       tax_payt_kind: 'НС',
  #       doc_no: '111',
  #       payt_reason: 'ТП'
  #     }
  #   )
  #   ed101.to_xml(Nokogiri::XML::Builder.new(encoding: 'UTF-8'), nil, nil).to_xml #=>
  #    '<?xml version="1.0" encoding="UTF-8"?>
  #    <ed:ED101 xmlns:ed="urn:cbr-ru:ed:v2.0" EDNo="7" EDDate="2017-12-11" EDAuthor="4525595000" Sum="150000" TransKind="01" ChargeOffDate="2017-12-11" ReceiptDate="2017-12-11" SystemCode="01" Priority="0">
  #      <ed:AccDoc AccDocNo="003" AccDocDate="2017-12-11"/>
  #      <ed:Payer INN="7726274727" PersonalAcc="40702810200203001037">
  #        <ed:Name>ООО ТЕСТ</ed:Name>
  #        <ed:Bank BIC="044525545" CorrespAcc="30101810300000000545"/>
  #      </ed:Payer>
  #      <ed:Payee INN="7726274727" PersonalAcc="40702810200203001037">
  #        <ed:Name>ООО ТЕСТ</ed:Name>
  #        <ed:Bank BIC="044525545" CorrespAcc="30101810300000000545"/>
  #      </ed:Payee>
  #      <ed:Purpose>оплата в том числе ндс 4000 руб</ed:Purpose>
  #      <ed:DepartmentalInfo CBC="18210301000010000110" OKATO="45263591000" TaxPeriod="МС.03.2017" DrawerStatus="01" PaytReason="ТП" DocNo="111" TaxPaytKind="НС" DocDate="2017-12-11"/>
  #    </ed:ED101>'
  def ED101(params)
    Ufebs::Documents::PaymentOrder.new(params)
  end

  def PackedEPD(payment_eds, params)
    Ufebs::Documents::Package.new(payment_eds, params)
  end

  def validate(doc)
    doc = Nokogiri::XML(doc) if doc.is_a?(String)

    errors = []
    validation_schema.validate(doc).each do |error|
      errors << error.message
      puts error.message
    end
    errors.empty?
  end
end
