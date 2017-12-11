require_relative 'payment_order'

module Ufebs
  module Documents
    class Package
      include HappyMapper
      tag 'PacketEPD'
      XMLNS                = "urn:cbr-ru:ed:v2.0".freeze

      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :number, String, tag: 'EDNo'
      attribute :quantity, String, tag: 'EDQuantity'
      attribute :sum, String, tag: 'Sum'
      attribute :system_code, String, tag: 'SystemCode'
      attribute :xmlns, String

      has_many :payment_orders, Ufebs::Documents::PaymentOrder

      def initialize(payment_orders, params = {})
        @payment_orders = payment_orders
        @ed_date   = Date.parse(params.fetch(:ed_date){Time.now}.to_s).strftime('%Y-%m-%d')
        @ed_author = params[:ed_author] || Utya::ED_AUTHOR
        @number    = params[:number]
        @quantity  = params[:quantity] || payment_orders.size
        @sum       = params[:sum] || payment_orders.sum(&:sum)
        @system_code   = '01'

        @xmlns = XMLNS
      end

      def to_xml
        super(Nokogiri::XML::Builder.new(:encoding => 'UTF-8')).to_xml
      end
    end
  end
end