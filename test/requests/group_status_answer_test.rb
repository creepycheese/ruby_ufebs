require_relative '../test_helper'

class Ufebs::Requests::GroupRequestTest < MiniTest::Test
  def test_it_forms_valid_xml
    pr = Ufebs::Requests::GroupStatusAnswer.new(
      ed_no:       '8',
      ed_date:     '2003-04-14',
      ed_author:   '4525545000',
      ed_receiver: '4525000000',
      status_code: '01',
      quantity_ed: '2',
      sum:         '6000000',
      initial_ed:  {
        ed_no:     '11',
        ed_date:   '2003-04-14',
        ed_author: '4525000000'
      },
      ed_infos: [
        {
          sum:       '2400000',
          ed_ref_id: {
            ed_no:     '7',
            ed_date:   '2003-04-14',
            ed_author: '4525000000'
          }
        },
        {
          sum:       '3600000',
          ed_ref_id: {
            ed_no:     '16',
            ed_date:   '2003-04-14',
            ed_author: '4525000000'
          }
        }
      ]
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert XML_VALIDATION.valid?(doc)
  end
end
