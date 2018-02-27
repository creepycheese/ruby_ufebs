require_relative 'payment_response'
require_relative '../entities/session'

module Ufebs
  module Documents
    class Package
      include HappyMapper
      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      tag 'PacketEPD'
      namespace 'ed'

      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :number, String, tag: 'EDNo'
      attribute :quantity, String, tag: 'EDQuantity'
      attribute :sum, String, tag: 'Sum'
      attribute :system_code, String, tag: 'SystemCode'

      has_many :payment_orders, Ufebs::Documents::PaymentOrder
      has_one :session, ::Ufebs::Entities::Session, tag: 'Session', state_when_nil: false

      def initialize(payment_orders=[], params = {})
        @payment_orders = payment_orders
        @ed_date   = Date.parse(params.fetch(:ed_date){Time.now}.to_s).strftime('%Y-%m-%d')
        @ed_author = params[:ed_author]
        @ed_receiver = params[:ed_receiver]
        @number    = params[:number]
        @quantity  = params[:quantity] || payment_orders.size
        @sum       = params[:sum]
        @system_code   = '01'
        super()
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(:encoding => encoding)).to_xml
      end
    end
  end
end

# <?xml version="1.0" encoding="WINDOWS-1251"?>
# <PacketESID xmlns="urn:cbr-ru:ed:v2.0" EDAuthor="4583001999" EDCreationTime="13:33:08" EDDate="2018-02-23" EDNo="1070230" EDReceiver="4525420000">
#   <dsig:SigValue xmlns:dsig="urn:cbr-ru:dsig:v1.1">MIIBaQYJKoZIhvcNAQcCoIIBWjCCAVYCAQExDjAMBggqhQMHAQECAgUAMAsGCSqGSIb3DQEHATGCATIwggEuAgEBMGAwTDELMAkGA1UEBhMCUlUxCzAJBgNVBAgTAjAwMQ8wDQYDVQQHEwZSVEdTQlIxDTALBgNVBAoTBEdDS0kxEDAOBgNVBAMTB0FETUlOQ0ECEEBQFMCd4KlDNKW6RlhblsQwDAYIKoUDBwEBAgIFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDIyNzEzMzIzMlowLwYJKoZIhvcNAQkEMSIEIPretuTeA+Uosyhj6ROUT66yYTuZF+aaXclhxXXKmPxdMAwGCCqFAwcBAQEBBQAEQD/Ah3zv5DZv13fsX1Pcqd3Z7YFls14j+4rnYkrRuU31oR1clc4YUG1Lg71Hrp7q/uErXapd33FrjKyxO7Dvfxo=</dsig:SigValue>
#   <InitialPacketED EDAuthor="4525420000" EDDate="2018-02-23" EDNo="5"/>
#   <Session>
#     <SessionID>6</SessionID>
#   </Session>
#   <ED206 Acc="30101810945250000420" BICCorr="044525000" CorrAcc="40101810845250010102" DC="1" EDAuthor="4583001999" EDDate="2018-02-23" EDNo="1070231" EDReceiver="4525420000" Sum="381" SystemCode="01" TransDate="2018-02-23" TransTime="13:33:08">
#     <AccDoc AccDocDate="2018-02-23" AccDocNo="441"/>
#     <EDRefID EDAuthor="4525420000" EDDate="2018-02-23" EDNo="6"/>
#     <ProcessingDetails CreditDate="2018-02-23" DebitDate="2018-02-23"/>
#   </ED206>
#   <ED206 Acc="30101810945250000420" BICCorr="044525000" CorrAcc="40101810045250010041" DC="1" EDAuthor="4583001999" EDDate="2018-02-23" EDNo="1070232" EDReceiver="4525420000" Sum="680700" SystemCode="01" TransDate="2018-02-23" TransTime="13:33:08">
#     <AccDoc AccDocDate="2018-02-23" AccDocNo="459"/>
#     <EDRefID EDAuthor="4525420000" EDDate="2018-02-23" EDNo="7"/>
#     <ProcessingDetails CreditDate="2018-02-23" DebitDate="2018-02-23"/>
#   </ED206>
# </PacketESID>
