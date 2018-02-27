require_relative '../test_helper'

class Ufebs::Requests::DefineRequestTest < MiniTest::Test
  def test_it_forms_valid_xml
    pr = Ufebs::Requests::DefineRequest.new(
      number:    '8',
      ed_date:   '2003-04-14',
      ed_author: '4525545000',
      ed_define_request_code: '01',
      original_epd:           {
        ed_no:     '8',
        ed_date:   '2003-04-14',
        ed_author: '4525545000',
      },
      ed_define_request_info: {
        acc_doc_date: '2003-04-14',
        acc_doc_no:   '8',
        payer_acc:    '11111111111111111111',
        payee_acc:    '11111111111111111111',
        sum:          '100000',
        payer_name:   'ТЕСТ',
        payee_name:   'ТЕСТ',
        ed_define_request_text: 'test',
        ed_filed_lists: [
          {
            field_no:    '110',
            field_value: '1'
          },
          {
            field_no:    '111',
            field_value: '1'
          }
        ],
        ed_define_reestr_infos: [
          {
            transaction_id:        '123',
            ed_reestr_filed_lists: [
              {
                field_no:    '110',
                field_value: '1'
              },
              {
                field_no:    '111',
                field_value: '1'
              }
            ]
          }
        ]
      }
    )

    doc = Nokogiri::XML(pr.to_xml)

    result = XML_VALIDATION.valid?(doc)
    assert result
  end
end

