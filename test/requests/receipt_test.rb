require_relative '../test_helper'

class Ufebs::Requests::PackageRequestTest < MiniTest::Test
  def test_it_forms_valid_xml
    pr = Ufebs::Requests::Receipt.new(
      number: '8',
      ed_date: '2003-04-14',
      ed_author: '4525545000',
      ed_receiver: '4525000000',
      abstract_date: Date.today,
      abstract_kind: '1',
      acc: '30101810945250000420',
      bic: '044525000',
      end_time: '00:47:07',
      enter_bal: '72619100',
      inquiry_session: '0',
      last_movet_date: Date.today,
      out_bal: '72619100',
      rtgs_unconfirmed_ed: '0',

      arrest_sum: '123123',
      credit_limit_sum: '213123',
      reserved_sum: '213123',

      trans_kind:         '01',
      sum:                '100',
      debit_sum:          '200',
      credit_sum:         '200',
      dc:                 '2',
      payer_personal_acc: '40000810000000000000',
      payee_personal_acc: '40000810000000000000',
      bic_corr:           '044123123',
      cash_doc_no:        '123',
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert XML_VALIDATION.valid?(doc)
  end
end
