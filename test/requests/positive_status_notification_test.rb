require_relative '../test_helper'

class Ufebs::Requests::PositiveStatusNotificationTest < MiniTest::Test
  def test_it_forms_valid_xml
    pr = Ufebs::Requests::PositiveStatusNotification.new(
      number:      '88',
      ed_date:     '2003-04-14',
      ed_author:   '4525545000',
      result_code: '2',
      ctrl_code:   '2900',
      annotation:  'ТЕСТ',
      ed_ref_id:   {
        ed_no:     '8',
        ed_date:   '2013-09-09',
        ed_author: '4525545000',
      }
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert XML_VALIDATION.valid?(doc)
  end
end
