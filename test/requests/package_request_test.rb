require_relative '../test_helper'

class Ufebs::Requests::PackageRequestTest < MiniTest::Test
  def test_it_forms_valid_xml
    pr = Ufebs::Requests::PackageRequest.new(
      number: '8',
      ed_date: '2003-04-14',
      ed_author: '4525545000',
      ed_receiver: '4525000000',
      ed_inqiery_code: 'RSPC',
      ref: {
        number: '7',
        date: '2003-04-14',
        author: '4525545000'
      }
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert XML_VALIDATION.valid?(doc)
  end
end