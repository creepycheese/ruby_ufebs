require_relative '../test_helper'

class Ufebs::Documents::PayerOrderTest < MiniTest::Test
  def test_it_parse_xml
    result = Ufebs::Documents::PayerOrder.parse(<<~XML.encode('windows-1251'))
      <?xml version="1.0" encoding="WINDOWS-1251"?>
      <PacketEPD EDAuthor="4583001999" EDDate="2018-01-03" EDNo="123"
                 EDQuantity="2" EDReceiver="4525420000" Sum="2" SystemCode="01"
                 xmlns="urn:cbr-ru:ed:v2.0">
        <Session>
          <SessionID>4</SessionID>
        </Session>
        <ED105 EDAuthor="4525416000" EDDate="2018-01-03" EDNo="17" Priority="5"
               Sum="1" SystemCode="01" TransKind="16" TransContent="String"
               CodePurpose="code purpose">
          <AccDoc AccDocDate="2018-01-03" AccDocNo="1"/>
          <Payer PersonalAcc="40817810000000000000">
            <Name>Пример</Name>
            <Bank BIC="044525416" CorrespAcc="30101810645250000416"/>
          </Payer>
          <Payee PersonalAcc="40817810000000000000">
            <Name>Пример</Name>
            <Bank BIC="044525420" CorrespAcc="30101810945250000420"/>
          </Payee>
          <Purpose>Пример</Purpose>
          <ProcessingDetails CreditDate="2018-01-03" DebitDate="2018-01-03"/>
        </ED105>
      </PacketEPD>
    XML

    assert result.any?
    assert result[0].trans_content == 'String'
    assert result[0].code_purpose == 'code purpose'
  end

  def test_it_maps_to_valid_xml
    po  = Ufebs::Documents::PayerOrder.new(
      number:            7,
      sum:               150000,
      ed_author:         '4525595000',
      system_code:       '02',
      trans_kind:        '16',
      acc_doc:           { number: '3', date: Time.now },
      purpose:           'оплата в том числе ндс 4000 руб',
      code_purpose:      'code purpose',
      trans_content:     'String',
      payer:             {
        name:         'ООО ТЕСТ',
        account:      '40702810200203001037',
        inn:          '7726274727',
        bank_bic:     '044525545',
        bank_account: '30101810300000000545'
      },
      payee:             {
        name:         'ООО ТЕСТ',
        account:      '40702810200203001037',
        inn:          '7726274727',
        bank_bic:     '044525545',
        bank_account: '30101810300000000545'
      },
      departmental_info: {
        kbk:           '18210301000010000110',
        okato:         '45263591000',
        drawer_status: '01',
        tax_period:    'МС.03.2017',
        tax_payt_kind: 'НС',
        doc_no:        '111',
        payt_reason:   'ТП'
      },
      partial_payt:      {
        payt_no:           '01',
        trans_kind:        '02',
        sum_residual_payt: 3000_00,
        acc_doc:           {
          number: '1',
          date:   '2018-12-12'
        }
      }
    )
    doc = Nokogiri::XML(po.to_xml)

    puts Ufebs.validate(doc).errors
    assert Ufebs.validate(doc).valid?
    assert po.priority == 0
    assert po.partial_payt.payt_no == '01'
    assert po.code_purpose == 'code purpose'
  end
end
