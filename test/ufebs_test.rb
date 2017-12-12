require_relative 'test_helper'

class UfebsTest < MiniTest::Test
  def test_ed999
    pr = Ufebs::Requests::TestRequest.new(
      number: '8',
      ed_date: '2003-04-14',
      ed_author: '4525545000')

    doc = Nokogiri::XML(pr.to_xml)
    assert Ufebs.validate(doc)
  end

  def test_it_maps_with_ed101
    po = Ufebs::ED101(
      number: 7,
      sum: 150000,
      receipt_date: Time.now,
      acc_doc: { number: '3', date: Time.now },
      ed_author: '4525545000',
      purpose: 'оплата в том числе ндс 4000 руб',
      payer: {
        name: 'ООО ТЕСТ',
        account: '40702810200203001037',
        inn: '7726274727',
        bank_bic: '044525545',
        bank_account: '30101810300000000545'
      },
      payee: {
        name: 'ООО ТЕСТ',
        account: '40702810200203001037',
        inn: '7726274727',
        bank_bic: '044525545',
        bank_account: '30101810300000000545'
      },
      departmental_info: {
        kbk: '18210301000010000110',
        okato: '45263591000',
        drawer_status: '01',
        tax_period: 'МС.03.2017',
        tax_payt_kind: 'НС',
        doc_no: '111',
        payt_reason: 'ТП'
      }
    )

    doc = Nokogiri::XML(po.to_xml)
    assert Ufebs.validate(doc)
  end
end
