require_relative 'test_helper'

class UfebsTest < MiniTest::Test
  def test_ed999
    pr = Ufebs::ED999(
      number: '8',
      ed_date: '2003-04-14',
      ed_author: '4525545000',
      creation_date_time: Time.now)

    doc = Nokogiri::XML(pr.to_xml)
    assert Ufebs.validate(doc).valid?
  end

  def test_ed799
    pr = Ufebs::ED799(
      number: '321',
      ed_date: '2003-04-14',
      ed_author: '4525545000',
      creation_date_time: Time.now
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert Ufebs.validate(doc).valid?
  end

  def test_ed710
    pr = Ufebs::ED710(
      ed_receiver: '1234567890',
      ed_no: '1',
      ed_date: Time.now,
      ed_author: '4525545000',
      bic_account: {
        bic: '123456789',
        correspondent_account: '40702810200203001037'
      }
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert Ufebs.validate(doc).valid?
  end

  def test_ed731
    pr = Ufebs::ED731(
      ed_receiver: '1234567890',
      ed_no: '1',
      ed_date: Time.now,
      ed_author: '4525545000',
      request_info: {
        bic: '123456789',
        correspondent_account: '40702810200203001037',
        sum: 1234,
        liquidity_trans_kind: 'INCL'
      },
      request_reason: {
        reason_code: 'ARRS'
      },
      ed_ref_id: {
        ed_no: '7',
        ed_date: Time.now,
        ed_author: '4525000000'
      }
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert Ufebs.validate(doc).valid?
  end

  def test_ed742
    pr = Ufebs::ED742(
      ed_receiver: '1234567890',
      ed_no: '1',
      ed_date: Time.now,
      ed_author: '4525545000',
      request_info: {
        bic: '123456789',
        correspondent_account: '40702810200203001037',
        date_time_interval: {
          begin_time: Time.now,
          end_time: Time.now
        }
      }
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert Ufebs.validate(doc).valid?
  end

  def test_ed806
    pr = Ufebs::ED806(
      ed_receiver: '1234567890',
      ed_no: '1',
      ed_date: Time.now,
      ed_author: '4525545000',
      request_code: 'FIRR',
      participant_id: {
        bic: '123456789'
      }
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert Ufebs.validate(doc).valid?
  end

  def test_it_maps_with_ed101
    po = Ufebs::ED101(
      number: 7,
      sum: 150000,
      receipt_date: Time.now,
      acc_doc: { number: '3', date: Time.now },
      ed_author: '4525545000',
      purpose: 'оплата в том числе ндс 4000 руб',
      payer: {
        name: 'ООО ТЕСТ',
        account: '40702810200203001037',
        inn: '7726274727',
        bank_bic: '044525545',
        bank_account: '30101810300000000545'
      },
      payee: {
        name: 'ООО ТЕСТ',
        account: '40702810200203001037',
        inn: '7726274727',
        bank_bic: '044525545',
        bank_account: '30101810300000000545'
      },
      departmental_info: {
        kbk: '18210301000010000110',
        okato: '45263591000',
        drawer_status: '01',
        tax_period: 'МС.03.2017',
        tax_payt_kind: 'НС',
        doc_no: '111',
        payt_reason: 'ТП'
      }
    )

    doc = Nokogiri::XML(po.to_xml)
    assert Ufebs.validate(doc).valid?
  end

  def test_it_parses_ed_211
    ed211_xml = <<~XML
      <?xml version="1.0" encoding="windows-1251"?>
      <ED211 xmlns="urn:cbr-ru:ed:v2.0" AbstractDate="2018-01-09" AbstractKind="1" Acc="30101810945250000420" BIC="044525000" EndTime="00:47:07"
      EnterBal="72619100" EDAuthor="4583001999" EDDate="2018-01-09" EDNo="1006815" EDReceiver="4525420000" InquirySession="0" LastMovetDate="2017-12-29" OutBal="72619100" RTGSUnconfirmedED="0"></ED211>
    XML
    assert_kind_of(Ufebs::Requests::Receipt, Ufebs::ED211(ed211_xml))
  end

  def test_ed_711_parse
    xml = <<~XML
      <?xml version="1.0" encoding="windows-1251"?>
      <ED711 CreationReason="RQST" CreationDateTime="1900-01-01T01:01:01+03:00" EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
      <BICAccount BIC="BIC1" CorrespAcc="CorrespAcc1" />
      <FPSLiquidityInfo BusinessDay="1900-01-01" FPSLiquidity="0" FPSEnterPosition="0" FPSPosition="0" CurrentBalance="1" ArrestSum="1" />
      <FPSTurnover FPSCreditSum="0" FPSDebetSum="0" />
      <LiqEDID Sum="0" LiquidityTransKind="INCL">
        <EDRefID EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
      </LiqEDID>
      <LiqEDID Sum="-999999999999999999" LiquidityTransKind="DECL">
        <EDRefID EDNo="-999999999" EDDate="0001-01-01" EDAuthor="EDAuthor2" />
      </LiqEDID>
      <LiqEDID Sum="999999999999999999" LiquidityTransKind="INCL">
        <EDRefID EDNo="999999999" EDDate="9999-12-31" EDAuthor="EDAuthor3" />
      </LiqEDID>
      <InitialED EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
      </ED711>
    XML

    assert_kind_of(Ufebs::Response::LiquidityInfo, Ufebs::ED711(xml))
  end
end
