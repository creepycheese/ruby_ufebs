require_relative '../test_helper'

class Ufebs::Response::LiquidityInfoTest < MiniTest::Test
  def setup
    xml = File.open('test/files/ed_711.xml').read
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
