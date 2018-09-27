require_relative '../test_helper'

class Ufebs::Documents::PaymentRequirementTest < MiniTest::Test
  def test_it_parse_xml
    result = Ufebs::Documents::PaymentRequirement.parse(<<~XML.encode('windows-1251'))
      <?xml version="1.0" encoding="WINDOWS-1251"?>
      <PacketEPD EDAuthor="4583001999" EDDate="2018-01-03" EDNo="123"
                 EDQuantity="2" EDReceiver="4525420000" Sum="2" SystemCode="01"
                 xmlns="urn:cbr-ru:ed:v2.0">
        <Session>
          <SessionID>4</SessionID>
        </Session>
        <ED103 EDAuthor="4525416000" EDDate="2018-01-03" EDNo="17" Priority="5"
               Sum="1" SystemCode="01" TransKind="02" TransContent="String" MaturityDate="2018-02-02">
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
        </ED103>
      </PacketEPD>
    XML

    assert result.any?
    assert result[0].maturity_date == '2018-02-02'
  end

  def test_it_maps_to_valid_xml
    po  = Ufebs::Documents::PaymentRequirement.new(
      number:            7,
      sum:               150000,
      ed_author:         '4525595000',
      system_code:       '02',
      trans_kind:        '02',
      acc_doc:           { number: '3', date: Time.now },
      purpose:                   'оплата в том числе ндс 4000 руб',
      receipt_date_collect_bank: '2018-02-03',
      file_date:                 '2018-02-04',
      payt_condition:            '2',
      acpt_term:                 '1',
      doc_dispatch_date:         '2018-02-05',
      maturity_date:             '2018-02-02',
      payer:                     {
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
      partial_payt: {
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
    assert po.maturity_date == '2018-02-02'
  end
end
