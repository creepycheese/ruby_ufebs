require_relative '../test_helper'

class Ufebs::Documents::CollectionOrderTest < MiniTest::Test
  def test_it_parse_xml
    result = Ufebs::Documents::CollectionOrder.parse(<<~XML.encode('windows-1251'))
      <?xml version="1.0" encoding="WINDOWS-1251"?>
      <PacketEPD EDAuthor="4583001999" EDDate="2018-01-03" EDNo="123"
                 EDQuantity="2" EDReceiver="4525420000" Sum="2" SystemCode="01"
                 xmlns="urn:cbr-ru:ed:v2.0">
        <Session>
          <SessionID>4</SessionID>
        </Session>
        <ED104 ChargeOffDate="2018-01-03" EDAuthor="4525416000" EDDate="2018-01-03"
               EDNo="17" Priority="5" ReceiptDate="2018-01-03" Sum="1" SystemCode="01"
               TransKind="06" FileDate="2018-01-03">
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
        </ED104>
      </PacketEPD>
    XML

    assert result.any?
    assert result[0].file_date == '2018-01-03'
  end
  
  def test_it_maps_to_valid_xml_with_processing_details
    po  = Ufebs::Documents::CollectionOrder.new(
      number:             7,
      sum:                150000,
      receipt_date:       Time.now,
      ed_author:          '4525595000',
      trans_kind:         '06',
      acc_doc:            {
        number: '3',
        date:   Time.now
      },
      purpose:            'оплата в том числе ндс 4000 руб',
      payment_precedence: '69',
      payer:              {
        name:         'ООО ТЕСТ',
        account:      '40702810200203001037',
        inn:          '7726274727',
        bank_bic:     '044525545',
        bank_account: '30101810300000000545'
      },
      payee:              {
        name:         'ООО ТЕСТ',
        account:      '40702810200203001037',
        inn:          '7726274727',
        bank_bic:     '044525545',
        bank_account: '30101810300000000545'
      },
      processing_details: {
        session: {
          session_type:    'NURG',
          settlement_time: '14:00:26'
        }
      }
    )
    doc = Nokogiri::XML(po.to_xml)
    puts Ufebs.validate(doc).errors
    assert Ufebs.validate(doc).valid?
  end

  def test_it_maps_to_valid_xml
    po  = Ufebs::Documents::CollectionOrder.new(
      number:            7,
      sum:               150000,
      receipt_date:      Time.now,
      ed_author:         '4525595000',
      system_code:       '02',
      trans_kind:        '06',
      acc_doc:           { number: '3', date: Time.now },
      purpose:           'оплата в том числе ндс 4000 руб',
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
      }
    )
    doc = Nokogiri::XML(po.to_xml)

    puts Ufebs.validate(doc).errors
    assert Ufebs.validate(doc).valid?
  end
end
