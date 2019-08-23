require_relative '../test_helper'

class Ufebs::Response::LiquidityInfoTest < MiniTest::Test
  def setup
    xml = <<~XML
      <?xml version="1.0" encoding="windows-1251"?>
      <ED711 CreationReason="RQST" CreationDateTime="1900-01-01T01:01:01+03:00" EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
      <BICAccount BIC="BIC1" CorrespAcc="CorrespAcc1" />
      <FPSLiquidityInfo BusinessDay="1900-01-01" FPSLiquidity="0" FPSEnterPosition="0" FPSPosition="0" CurrentBalance="1" ArrestSum="1" />
      <FPSTurnover FPSCreditSum="0" FPSDebetSum="0" />
      <LiqEDID Sum="-1" LiquidityTransKind="INCL">
        <EDRefID EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
      </LiqEDID>
      <LiqEDID Sum="-999999999999999999" LiquidityTransKind="DECL">
        <EDRefID EDNo="-999999999" EDDate="0001-01-01" EDAuthor="EDAuthor2" />
      </LiqEDID>
      <LiqEDID Sum="999999999999999999" LiquidityTransKind="INCL">
        <EDRefID EDNo="999999999" EDDate="9999-12-31" EDAuthor="EDAuthor3" />
      </LiqEDID>
      <InitialED EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
      </ED711>
    XML
    @parsed_xml = Ufebs::ED711(xml)
  end
  
  def test_creation_reason_and_time
    assert_equal('RQST', @parsed_xml.creation_reason)
    assert_equal('1900-01-01T01:01:01+03:00', @parsed_xml.creation_date_time)
  end

  def test_bic_account
    assert_equal('BIC1', @parsed_xml.bic_account.bic)
    assert_equal('CorrespAcc1', @parsed_xml.bic_account.correspondent_account)
  end

  def test_fps_liquidity_info
    assert_equal('1900-01-01', @parsed_xml.fps_liquidity_info.business_day)
    assert_equal(0, @parsed_xml.fps_liquidity_info.fps_liquidity)
    assert_equal(0, @parsed_xml.fps_liquidity_info.fps_enter_position)
    assert_equal(0, @parsed_xml.fps_liquidity_info.fps_position)
    assert_equal(1, @parsed_xml.fps_liquidity_info.current_balance)
    assert_equal(1, @parsed_xml.fps_liquidity_info.arrest_sum)
  end

  def test_fps_turnover
    assert_equal(0, @parsed_xml.fps_turnover.credit_sum)
    assert_equal(0, @parsed_xml.fps_turnover.debet_sum)
  end

  def test_initial_ed
    assert_equal('1', @parsed_xml.initial_ed.ed_no)
    assert_equal('1900-01-01', @parsed_xml.initial_ed.ed_date)
    assert_equal('EDAuthor1', @parsed_xml.initial_ed.ed_author)
  end

  def test_liq_edid
    assert_kind_of(::Ufebs::Response::LiqEDID, @parsed_xml.liq_edid.first)
    assert_kind_of(Ufebs::Entities::EdRefId, @parsed_xml.liq_edid.first.ed_ref_id)
    assert_equal(-1, @parsed_xml.liq_edid.first.sum)
    assert_equal('INCL', @parsed_xml.liq_edid.first.liquidity_trans_kind)
  end
end
