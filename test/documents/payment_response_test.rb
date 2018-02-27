require_relative '../test_helper'

class Ufebs::Documents::PaymentResponseTest < MiniTest::Test
  def test_it_maps_to_valid_xml
    po = Ufebs::Documents::PaymentResponse.new(
      acc: '30101810945250000420',
      bic_corr: '044525000',
      corr_acc: '40101810045250010041',
      dc: '1',
      ed_author: '4583001999',
      ed_date: '2018-02-23',
      sum: '680700',
      ed_receiver: '4525420000',
      ed_no: '1070232',
      system_code: '01',
      trans_date: '2018-02-23',
      trans_time: '13:33:08',
      acc_doc: {
        date: '2018-02-23',
        number: '459'
      },
      ed_ref_id: {
        ed_no: '7',
        ed_date: '2018-02-23',
        ed_author: '4525420000'
      },
      processing_details: {
        debit_date: '2018-02-23',
        credit_date: '2018-02-23'
      }
    )

    doc = Nokogiri::XML(po.to_xml)
    assert Ufebs.validate(doc)
  end
end
