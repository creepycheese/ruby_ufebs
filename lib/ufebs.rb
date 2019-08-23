require 'happymapper'
require "ufebs/version"
require "ufebs/configuration"
require "ufebs/schema_validation_result"

Dir[File.dirname(__FILE__) + '/**/entities/*.rb'].each { |ff| require ff }
Dir[File.dirname(__FILE__) + '/**/fields/*.rb'].each { |ff| require ff }
Dir[File.dirname(__FILE__) + '/**/documents/*.rb'].each { |ff| require ff }
Dir[File.dirname(__FILE__) + '/**/requests/*.rb'].each { |ff| require ff }
Dir[File.dirname(__FILE__) + '/**/response/*.rb'].each { |ff| require ff }

module Ufebs
  extend self

  def namespace
    "urn:cbr-ru:ed:v2.0".freeze
  end

  # Получение Сессии(Номера рейса)
  # @return [Ufebs::Entities::Session]
  # @example Пример
  #   session = Ufebs::Session(File.read('doc.xml')) #=> #<Ufebs::Entities::Session:0x00..>
  def Session(params)
    params.is_a?(Hash) ? Ufebs::Entities::Session.new(params) : Ufebs::Entities::Session.parse(params, single: true)
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
  # @return [Ufebs::Documents::PaymentOrder, Array<Ufebs::Documents::PaymentOrder>] Представление документа УФЕБС
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
  # @example Чтение XML
  #   Ufebs::ED101(File.read('packet_epd.xml')) #=> [#<Ufebs::Documents::PaymentOrder:0x00..>]
  def ED101(params)
    params.is_a?(Hash) ? Ufebs::Documents::PaymentOrder.new(params) : Ufebs::Documents::PaymentOrder.parse(params)
  end

  def ED103(params)
    params.is_a?(Hash) ? Ufebs::Documents::PaymentRequirement.new(params) : Ufebs::Documents::PaymentRequirement.parse(params)
  end

  def ED104(params)
    params.is_a?(Hash) ? Ufebs::Documents::CollectionOrder.new(params) : Ufebs::Documents::CollectionOrder.parse(params)
  end

  def ED105(params)
    params.is_a?(Hash) ? Ufebs::Documents::PayerOrder.new(params) : Ufebs::Documents::PayerOrder.parse(params)
  end

  def ED107(params)
    params.is_a?(Hash) ? Ufebs::Documents::PaymentOrderEd107.new(params) : Ufebs::Documents::PaymentOrderEd107.parse(params)
  end

  def ED108(params)
    params.is_a?(Hash) ? Ufebs::Documents::PaymentOrderEd108.new(params) : Ufebs::Documents::PaymentOrderEd108.parse(params)
  end

  def ED109(params)
    params.is_a?(Hash) ? Ufebs::Documents::BankOrder.new(params) : Ufebs::Documents::BankOrder.parse(params)
  end

  def ED110(params)
    params.is_a?(Hash) ? Ufebs::Documents::SomeOrder.new(params) : Ufebs::Documents::SomeOrder.parse(params)
  end

  def ED111(params)
    params.is_a?(Hash) ? Ufebs::Documents::MemorialOrder.new(params) : Ufebs::Documents::MemorialOrder.parse(params)
  end

  def ED201(params)
    Ufebs::Requests::NegativeStatusNotification.parse(params)
  end

  def ED205(params)
    Ufebs::Requests::StatusAnswer.parse(params)
  end

  def ED206(params)
    return Ufebs::Documents::PaymentResponse.new(params) if params.is_a?(Hash)
    Ufebs::Documents::PaymentResponse.parse(params)
  end

  def ED207(params)
    return Ufebs::Requests::GroupStatusAnswer.new(params) if params.is_a?(Hash)
    Ufebs::Requests::GroupStatusAnswer.parse(params)
  end

  def ED208(params)
    Ufebs::Requests::PositiveStatusNotification.parse(params)
  end

  def ED210(params)
  end

  # Создание/Парсинг выписки ED211
  # @example Пример
  #   ed211 = Ufebs::Requests::Receipt.new(
  #     number: '8',
  #     ed_date: '2003-04-14',
  #     ed_author: '4525545000',
  #     ed_receiver: '4525000000',
  #     abstract_date: Date.today,
  #     abstract_kind: '1',
  #     acc: '30101810945250000420',
  #     bic: '044525000',
  #     end_time: '00:47:07',
  #     enter_bal: '72619100',
  #     inquiry_session: '0',
  #     last_movet_date: Date.today,
  #     out_bal: '72619100',
  #     rtgs_unconfirmed_ed: '0'
  #   )
  def ED211(params)
    params.is_a?(Hash) ? Ufebs::Requests::Receipt.new(params) : Ufebs::Requests::Receipt.parse(params)
  end

  def ED218(params)
  end

  def ED243(params)
    if params.is_a?(Hash)
      Ufebs::Requests::DefineRequest.new(params)
    else
      Ufebs::Requests::DefineRequest.parse(params)
    end
  end

  def ED244(params)
    if params.is_a?(Hash)
      Ufebs::Requests::DefineAnswer.new(params)
    else
      Ufebs::Requests::DefineAnswer.parse(params)
    end
  end

  # Запрос информации о состоянии ликвидности в СБП
  # params = {
  #   ed_receiver: '1234567890',
  #   ed_no: '1',
  #   ed_date: Time.now,
  #   ed_author: '4525545000',
  #   bic_account: {
  #     bic: '123456789',
  #     correspondent_account: '40702810200203001037'
  #   }
  # }
  def ED710(params)
    Ufebs::Requests::LiquidityInfo.new(params)
  end

  # Извещения о состоянии ликвидности в СБП
  def ED711(xml)
    Ufebs::Response::LiquidityInfo.parse(xml)
  end

  # Запрос на увеличение или уменьшение позиции в СБП 
  # params = {
  #   ed_receiver: '1234567890',
  #   ed_no: '1',
  #   ed_date: Time.now,
  #   ed_author: '4525545000',
  #   request_info: {
  #     bic: '123456789',
  #     correspondent_account: '40702810200203001037',
  #     sum: 1234,
  #     liquidity_trans_kind: 'INCL'
  #   },
  #   request_reason: {
  #     reason_code: 'ARRS'
  #   },
  #   ed_ref_id: {
  #     ed_no: '7',
  #     ed_date: Time.now,
  #     ed_author: '4525000000'
  #   }
  # }
  def ED731(params)
    Ufebs::Requests::LiquidityChange.new(params)
  end
  
  # Запрос на получение потранзакционного реестра
  # params = {
  #   ed_receiver: '1234567890',
  #   ed_no: '1',
  #   ed_date: Time.now,
  #   ed_author: '4525545000',
  #   request_info: {
  #     bic: '123456789',
  #     correspondent_account: '40702810200203001037',
  #     date_time_interval: {
  #       begin_time: Time.now,
  #       end_time: Time.now
  #     }
  #   }
  # }
  def ED742(params)
    Ufebs::Requests::GetRegistry.new(params)
  end

  # Запрос-зонд
  # @param params [Hash]
  # @option :number аттрибут EDNo
  # @option :ed_date аттрибут EDDate
  # @option :ed_author аттрибут EDAuthor
  # @option :creation_date_time аттрибут CreationDateTime
  def ED799(params)
    Ufebs::Requests::SbpTestRequest.new(params)
  end

  # Запрос Справочника БИК и запрос Профиля участника
  # params = {
  #   ed_receiver: '1234567890',
  #   ed_no: '1',
  #   ed_date: Time.now,
  #   ed_author: '4525545000',
  #   request_code: 'FIRR',
  #   participant_id: {
  #     bic: '123456789'
  #   }
  # }
  def ED806(params)
    Ufebs::Requests::ParticipantProfile.new(params)
  end
  
  # XML запрос-зонд
  # @param params [Hash]
  # @option :number аттрибут EDNo
  # @option :ed_date аттрибут EDDate
  # @option :ed_author аттрибут EDAuthor
  def ED999(params)
    Ufebs::Requests::TestRequest.new(params)
  end

  def PacketEPD(payment_eds, params)
    Ufebs::Documents::Package.new(payment_eds, params)
  end

  def PacketESID(params)
    Ufebs::Documents::PackageResponse.parse(params)
  end

  def validate(doc)
    doc = Nokogiri::XML(doc) if doc.is_a?(String)

    errors = []
    validation_schema.validate(doc).each do |error|
      errors << error.message
    end

    Ufebs::SchemaValidationResult.new(errors)
  end
end
