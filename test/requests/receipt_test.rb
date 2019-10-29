# frozen_string_literal: true

require_relative '../test_helper'

class Ufebs::Requests::ReceiptTest < MiniTest::Test
  def test_it_forms_valid_xml
    pr = Ufebs::Requests::Receipt.new(
      number: '8',
      ed_date: '2003-04-14',
      ed_author: '4525545000',
      ed_receiver: '4525000000',
      abstract_date: Date.today,
      abstract_kind: '1',
      acc: '30101810945250000420',
      bic: '044525000',
      end_time: '00:47:07',
      enter_bal: '72619100',
      inquiry_session: '0',
      last_movet_date: Date.today,
      out_bal: '72619100',
      rtgs_unconfirmed_ed: '0',
      arrest_sum: '123123',
      credit_limit_sum: '213123',
      reserved_sum: '213123',
      debit_sum: '200',
      credit_sum: '200',
      trans_infos:
        [
          {
            acc_doc_no: '123',
            bic_corr: '044123123',
            dc: '2',
            payee_personal_acc: '40000810000000000000',
            payer_personal_acc: '40000810000000000000',
            sum: '100',
            trans_kind: '01',
            turnover_kind: '1',
            cash_doc_no: '123',
            ed_ref_id: {
              ed_no: '123',
              ed_date: '2018-02-12',
              ed_author: '4444111000'
            }
          }
        ]
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert XML_VALIDATION.valid?(doc)
  end

  def test_it_forms_valid_xml_with_processing_details
    pr = Ufebs::Requests::Receipt.new(
      number: '8',
      ed_date: '2003-04-14',
      ed_author: '4525545000',
      ed_receiver: '4525000000',
      abstract_date: Date.today,
      abstract_kind: '1',
      acc: '30101810945250000420',
      bic: '044525000',
      end_time: '00:47:07',
      enter_bal: '72619100',
      inquiry_session: '0',
      last_movet_date: Date.today,
      out_bal: '72619100',
      rtgs_unconfirmed_ed: '0',
      arrest_sum: '123123',
      credit_limit_sum: '213123',
      reserved_sum: '213123',
      debit_sum: '200',
      credit_sum: '200',
      trans_infos:
        [
          {
            acc_doc_no: '123',
            bic_corr: '044123123',
            dc: '2',
            payee_personal_acc: '40000810000000000000',
            payer_personal_acc: '40000810000000000000',
            sum: '100',
            trans_kind: '01',
            turnover_kind: '1',
            cash_doc_no: '123',
            ed_ref_id: {
              ed_no: '123',
              ed_date: '2018-02-12',
              ed_author: '4444111000'
            }
          }
        ],
      processing_details: {
        session: {
          session_type: 'NURG',
          settlement_time: '14:00:26'
        }
      }
    )

    doc = Nokogiri::XML(pr.to_xml)
    assert XML_VALIDATION.valid?(doc)
  end

  def test_parsing_with_liquidity
    xml = <<~XML
      <?xml version="1.0" encoding="windows-1251"?>
      <ED211 xmlns="urn:cbr-ru:ed:v2.0" AbstractDate="2018-01-09" AbstractKind="1" Acc="30101810945250000420" BIC="044525000" EndTime="00:47:07" EnterBal="72619100" EDAuthor="4583001999" EDDate="2018-01-09" EDNo="1006815" EDReceiver="4525420000">
        <TransInfo AccDocNo="347275" AccDocDate="2019-10-28" TransKind="01" BICCorr="047501711" PayerPersonalAcc="40817810660000157914" PayeePersonalAcc="40702810807110008530" TurnoverKind="1" DC="1" Sum="30000000">
          <EDRefID EDNo="190" EDDate="2019-10-29" EDAuthor="4525420000"/>
        </TransInfo>
        <FPSInfo FPSLiquidity="100000000" EnterBalance="40087530967" CurrentBalance="39421851223" FPSCreditSum="5643726423" FPSDebetSum="7589454673"/>
      </ED211>
    XML
    parsed_xml = Ufebs::ED211(xml)

    assert(parsed_xml.fps_info.fps_liquidity, 1_000_000_00)
    assert(parsed_xml.fps_info.enter_balance, 400_875_309_67)
    assert(parsed_xml.fps_info.current_balance, 39_421_851_223)
    assert(parsed_xml.fps_info.current_balance, 39_421_851_223)
    assert(parsed_xml.fps_info.fps_credit_sum, 56_437_264_23)
    assert(parsed_xml.fps_info.fps_debet_sum, 75_894_546_73)
  end
end
