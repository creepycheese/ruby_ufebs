# frozen_string_literal: true

module Ufebs
  module Response
    class LiquidityChange
      include HappyMapper

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'

      tag 'ED732'
      namespace 'ed'

      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'

      has_one :request_info, Ufebs::Entities::RequestInfo, tag: 'RequestInfo'
      has_one :liquidity_info, 'Ufebs::Response::Info', tag: 'LiquidityInfo'
      has_one :initial_ed, Ufebs::Entities::EdRefId, tag: 'InitialED'
    end

    class Info
      include HappyMapper

      attribute :fps_liquidity, Integer, tag: 'FPSLiquidity'
      attribute :fps_position, Integer, tag: 'FPSPosition'
      attribute :exec_code, String, tag: 'ExecCode'
    end
  end
end

# <ED732 EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
#   <RequestInfo BIC="BIC1" CorrespAcc="CorrespAcc1" Sum="0" LiquidityTransKind="INCL" />
#   <LiquidityInfo FPSLiquidity="0" FPSPosition="0" ExecCode="EXEC" />
#   <InitialED EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
# </ED732>
