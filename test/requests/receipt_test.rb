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
      rtgs_unconfirmed_ed: '0'
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert XML_VALIDATION.valid?(doc)
  end
end
