# frozen_string_literal: true

require_relative '../test_helper'

class Ufebs::Response::GetRegistryTest < MiniTest::Test
  def setup
    xml = File.open('test/files/ed_743.xml').read
    @parsed_xml = Ufebs::ED743(xml)
  end

  def test_part_info
    assert_equal('1', @parsed_xml.part_info.part_no)
    assert_equal(1, @parsed_xml.part_info.part_quantity)
    assert_equal('PartAggregateID1', @parsed_xml.part_info.part_aggregate_id)
  end

  def test_fps_trans_infos
    assert_equal('BICCorr1', @parsed_xml.fps_trans_infos.first.bic_corr)
    assert_equal('CorrespAcc1', @parsed_xml.fps_trans_infos.first.correspondent_account)
    assert_equal('DEBT', @parsed_xml.fps_trans_infos.first.dc)
  end

  def test_trans_infos
    first_trans_info = @parsed_xml.fps_trans_infos.first.trans_infos.first

    assert_equal('TransactionID1', first_trans_info.transaction_id)
    assert_equal(0, first_trans_info.sum)
    assert_equal('PUSH', first_trans_info.operation_type)
    assert_equal('1900-01-01T01:01:01+03:00', first_trans_info.trans_date_time)
    assert_equal(3, @parsed_xml.fps_trans_infos.first.trans_infos.size)
  end
end
