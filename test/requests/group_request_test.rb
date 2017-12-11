require_relative '../test_helper'

class Ufebs::Requests::GroupRequestTest < MiniTest::Test
  def test_it_forms_valid_xml
    pr = Ufebs::Requests::GroupRequest.new(
      number: '8',
      ed_date: '2003-04-14',
      ed_author: '4525545000',
      ed_receiver: '4525000000',
      group_inquiry_code: '1',
      account: '30101810300000000545',
      status_code: '00'
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert XML_VALIDATION.valid?(doc)
  end
end
