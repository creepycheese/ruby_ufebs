require_relative 'payment_order'
require_relative '../entities/session'

module Ufebs
  module Documents
    class Package
      include HappyMapper
      SYSTEM_CODE = '02'
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
        @system_code   = params.fetch(:system_code) { SYSTEM_CODE }
        super()
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(:encoding => encoding)).to_xml
      end
    end
  end
end
