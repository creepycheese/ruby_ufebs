require_relative '../test_helper'

class Ufebs::Requests::DefineAnswerTest < MiniTest::Test
  def test_it_forms_valid_xml
    pr = Ufebs::Requests::DefineAnswer.new(
      number:    '8',
      ed_date:   '2003-04-14',
      ed_author: '4525545000',
      ed_receiver: '4525545000',
      ed_define_request_code: '01',
      ed_define_answer_code: '01',
      payer_name:             'ТЕСТ',
      original_epd:           {
        ed_no:     '8',
        ed_date:   '2003-04-14',
        ed_author: '4525545000',
      },
      ed_define_answer_info: {
        acc_doc_date:          '2003-04-14',
        acc_doc_no:            '8',
        payer_acc:             '11111111111111111111',
        payee_acc:             '11111111111111111111',
        payer_inn:             '666666666',
        payee_inn:             '666666666',
        sum:                   '100000',
        enter_date:            '1900-01-01',
        payee_corr_acc:        '11111111111111111111',
        payee_bic:             '666666666',
        payer_long_name:       'test',
        payee_long_name:       'test',
        purpose:               'test',
        address:               'test',
        ed_define_answer_text: 'test',

        ed_field_lists: [
          {
            field_no:    '110',
            field_value: '1'
          }
        ],
        ed_define_reestr_infos: [
          {
            transaction_id:        '123',
            ed_reestr_field_lists: [
              {
                field_no:    '110',
                field_value: '1'
              }
            ]
          }
        ]
      }
    )

    doc = Nokogiri::XML(pr.to_xml)

    result = XML_VALIDATION.valid?(doc)
    unless result
      puts XML_VALIDATION.validate(doc)
      puts
      puts doc.to_xml
    end
    assert result
  end
end

