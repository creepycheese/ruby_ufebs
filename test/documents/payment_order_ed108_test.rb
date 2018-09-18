require_relative '../test_helper'

class Ufebs::Documents::PaymentOrderED108Test < MiniTest::Test
  def test_it_parse_xml
    result = Ufebs::Documents::PaymentOrderEd108.parse(<<~XML.encode('windows-1251'))
      <?xml version="1.0" encoding="WINDOWS-1251"?>
      <ED108 EDNo="555555585" EDDate="2018-07-02" EDAuthor="4525470000" Sum="125"
             TransKind="01" Priority="5" ReceiptDate="2018-07-02"
             ChargeOffDate="2018-07-02" SystemCode="02" xmlns="urn:cbr-ru:ed:v2.0">
        <AccDoc AccDocNo="125" AccDocDate="2018-07-02"/>
        <Payer>
          <Name>пример наименования плательщика</Name>
          <Bank BIC="044525470" CorrespAcc="30101810200000000470"/>
        </Payer>
        <Payee PersonalAcc="40101810500000001901">
          <Name>пример наименования получателя средств</Name>
          <Bank BIC="044501002"/>
        </Payee>
        <Purpose>пример назначения платежа</Purpose>
        <CreditTransferTransactionInfo TransactionID="1" PayerDocNo="1"
                                       PayerDocDate="2018-07-02" OperationID="1"
                                       TransactionDate="2018-07-02"
                                       TransactionSum="125">
          <TransactionPayerInfo Acc="10601810500000000000">
            <PersonName>Иванов И.И.</PersonName>
            <PersonAddress>Москва</PersonAddress>
            <TradeName>пример наименования</TradeName>
          </TransactionPayerInfo>
          <TransactionPayeeInfo Acc="10601810200000000000">
            <PersonName>Сидоров С.С</PersonName>
            <PersonAddress>Москва</PersonAddress>
            <TradeName>пример наименования</TradeName>
          </TransactionPayeeInfo>
          <TransactionPurpose>пример назначения платежа</TransactionPurpose>
          <RemittanceInfo>пример</RemittanceInfo>
          <TransactionBeneficiaryInfo>
            <PersonName>Петров П.П.</PersonName>
            <PersonAddress>Москва</PersonAddress>
            <TradeName>пример наименования</TradeName>
          </TransactionBeneficiaryInfo>
        </CreditTransferTransactionInfo>
      </ED108>
    XML

    assert !result.nil?
  end
end
