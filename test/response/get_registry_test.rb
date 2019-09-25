# frozen_string_literal: true

require_relative '../test_helper'

class Ufebs::Response::GetRegistryTest < MiniTest::Test
  def setup
    xml = File.open('test/files/ed_743.xml').read
    @parsed_xml = Ufebs::ED743(xml)
  end

  def test_part_info
    assert_equal('1', @parsed_xml.part_info.number)
    assert_equal(1, @parsed_xml.part_info.quantity)
    assert_equal('PartAggregateID1', @parsed_xml.part_info.aggregate_id)
  end

  def test_trans_infos
    assert_equal('BICCorr1', @parsed_xml.trans_infos.first.bic)
    assert_equal('CorrespAcc1', @parsed_xml.trans_infos.first.correspondent_account)
    assert_equal('DEBT', @parsed_xml.trans_infos.first.dc)
  end

  def test_transactions
    transaction = @parsed_xml.trans_infos.first.transactions.first

    assert_equal('TransactionID1', transaction.id)
    assert_equal(0, transaction.amount)
    assert_equal('PUSH', transaction.operation_type)
    assert_equal('1900-01-01T01:01:01+03:00', transaction.date_time)
    assert_equal(3, @parsed_xml.trans_infos.first.transactions.size)
  end
end
