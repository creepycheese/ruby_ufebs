require_relative '../test_helper'

class Ufebs::Documents::PackageTest < MiniTest::Test
  def test_it_creates_valid_package_xml
    po = 3.times.map do
     Ufebs::Documents::PaymentOrder.new(
        number: 7,
        sum: 150000,
        receipt_date: Time.now,
        acc_doc: Ufebs::Entities::AccDoc.new(number: '123', date: Time.now),
        purpose: 'оплата по  том числе ндс 4000 руб',
        departmental_info: nil
      ) do |p|
        p.payer.name = 'ООО Тест'
        p.payer.account = '40702810200203001037'
        p.payer.inn = '7726274727'
        p.payer.bank.bic = '044525545'
        p.payer.bank.account = '30101810300000000545'

        p.payee.name = 'Test Test'
        p.payee.account = '40702810200203001037'
        p.payee.inn = '7726274727'
        p.payee.bank.bic = '044525545'
        p.payee.bank.account = '30101810300000000545'
      end
    end

    pack = Ufebs::Documents::Package.new(
      po,
      ed_date: '2017-07-10',
      ed_author: '4525545000',
      quantity: '5',
      sum: '4900000',
      number: '21'
    )

    doc = Nokogiri::XML(pack.to_xml)
    assert XML_VALIDATION.valid?(doc)
  end
end

