# frozen_string_literal: true

module Ufebs
  module Response
    class LiquidityInfo
      include HappyMapper

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'

      tag 'ED711'
      namespace 'ed'

      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :creation_reason, String, tag: 'CreationReason'
      attribute :creation_date_time, String, tag: 'CreationDateTime'

      has_one :bic_account, Ufebs::Entities::BicAccount, tag: 'BICAccount'
      has_one :fps_liquidity_info, 'Ufebs::Response::FPSLiquidityInfo', tag: 'FPSLiquidityInfo'
      has_one :fps_turnover, 'Ufebs::Response::FPSTurnover', tag: 'FPSTurnover'
      has_one :initial_ed, 'Ufebs::Response::InitialED', tag: 'InitialED'
      has_many :liq_edid, 'Ufebs::Response::LiqEDID', tag: 'LiqEDID'

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(encoding: encoding)).to_xml
      end
    end

    class FPSLiquidityInfo
      include HappyMapper

      attribute :business_day, String, tag: 'BusinessDay'
      attribute :fps_liquidity, Integer, tag: 'FPSLiquidity'
      attribute :fps_enter_position, Integer, tag: 'FPSEnterPosition'
      attribute :fps_position, Integer, tag: 'FPSPosition'
      attribute :current_balance, Integer, tag: 'CurrentBalance'
      attribute :arrest_sum, Integer, tag: 'ArrestSum'
    end

    class FPSTurnover
      include HappyMapper

      attribute :credit_sum, Integer, tag: 'FPSCreditSum'
      attribute :debet_sum, Integer, tag: 'FPSDebetSum'
    end

    class InitialED
      include HappyMapper

      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
    end

    class LiqEDID
      include HappyMapper

      attribute :sum, Integer, tag: 'Sum'
      attribute :liquidity_trans_kind, String, tag: 'LiquidityTransKind'

      has_one :ed_ref_id, ::Ufebs::Entities::EdRefId, tag: 'EDRefID'
    end
  end
end

# <ED711 CreationReason="RQST" CreationDateTime="1900-01-01T01:01:01+03:00" EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
#   <BICAccount BIC="BIC1" CorrespAcc="CorrespAcc1" />
#   <FPSLiquidityInfo BusinessDay="1900-01-01" FPSLiquidity="0" FPSEnterPosition="0" FPSPosition="0" CurrentBalance="1" ArrestSum="1" />
#   <FPSTurnover FPSCreditSum="0" FPSDebetSum="0" />
#   <LiqEDID Sum="0" LiquidityTransKind="INCL">
#     <EDRefID EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
#   </LiqEDID>
#   <LiqEDID Sum="-999999999999999999" LiquidityTransKind="DECL">
#     <EDRefID EDNo="-999999999" EDDate="0001-01-01" EDAuthor="EDAuthor2" />
#   </LiqEDID>
#   <LiqEDID Sum="999999999999999999" LiquidityTransKind="INCL">
#     <EDRefID EDNo="999999999" EDDate="9999-12-31" EDAuthor="EDAuthor3" />
#   </LiqEDID>
#   <InitialED EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
# </ED711>
