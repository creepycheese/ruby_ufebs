# frozen_string_literal: true

require_relative '../test_helper'

class Ufebs::Response::LiquidityChangeTest < MiniTest::Test
  def setup
    xml = File.open('test/files/ed_732.xml').read
    @parsed_xml = Ufebs::ED732(xml)
  end

  def test_request_info
    assert_equal('BIC1', @parsed_xml.request_info.bic)
    assert_equal('CorrespAcc1', @parsed_xml.request_info.correspondent_account)
    assert_equal(0, @parsed_xml.request_info.sum)
    assert_equal('INCL', @parsed_xml.request_info.liquidity_trans_kind)
  end

  def test_liquidity_info
    assert_equal(0, @parsed_xml.liquidity_info.fps_liquidity)
    assert_equal(0, @parsed_xml.liquidity_info.fps_position)
    assert_equal('EXEC', @parsed_xml.liquidity_info.exec_code)
  end

  def test_initial_ed
    assert_equal('1', @parsed_xml.initial_ed.ed_no)
    assert_equal('EDAuthor1', @parsed_xml.initial_ed.ed_author)
    assert_equal('1900-01-01', @parsed_xml.initial_ed.ed_date)
  end
end
