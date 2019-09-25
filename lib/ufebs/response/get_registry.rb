# frozen_string_literal: true

module Ufebs
  module Response
    class GetRegistry
      include HappyMapper

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'

      tag 'ED743'
      namespace 'ed'

      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :creation_date_time, String, tag: 'CreationDateTime'

      has_one :request_info, Ufebs::Entities::RequestInfo, tag: 'RequestInfo'
      has_one :part_info, 'Ufebs::Response::PartInfo', tag: 'PartInfo'
      has_one :initial_ed, Ufebs::Entities::EdRefId, tag: 'InitialED'

      has_many :trans_infos, 'Ufebs::Response::FPSTransInfo', tag: 'FPSTransInfo'
    end

    class PartInfo
      include HappyMapper

      namespace 'ed'

      attribute :number, String, tag: 'PartNo'
      attribute :quantity, Integer, tag: 'PartQuantity'
      attribute :aggregate_id, String, tag: 'PartAggregateID'
    end

    class FPSTransInfo
      include HappyMapper

      namespace 'ed'

      attribute :bic, String, tag: 'BICCorr'
      attribute :correspondent_account, String, tag: 'CorrespAcc'
      attribute :dc, String, tag: 'DC'

      has_many :transactions, 'Ufebs::Response::TransInfo', tag: 'TransInfo'
    end

    class TransInfo
      include HappyMapper

      namespace 'ed'

      attribute :id, String, tag: 'TransactionID'
      attribute :amount, Integer, tag: 'Sum'
      attribute :operation_type, String, tag: 'OperationType'
      attribute :date_time, String, tag: 'TransDateTime'
    end
  end
end

# <ED743 CreationDateTime="1900-01-01T01:01:01+03:00" EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
#   <PartInfo PartNo="1" PartQuantity="1" PartAggregateID="PartAggregateID1" />
#   <RequestInfo BIC="BIC1" CorrespAcc="CorrespAcc1">
#     <DateTimeInterval BeginTime="1900-01-01T01:01:01+03:00" EndTime="1900-01-01T01:01:01+03:00" />
#   </RequestInfo>
#   <FPSTransInfo BICCorr="BICCorr1" CorrespAcc="CorrespAcc1" DC="DEBT">
#     <TransInfo TransactionID="TransactionID1" Sum="0" OperationType="PUSH" TransDateTime="1900-01-01T01:01:01+03:00" />
#     <TransInfo TransactionID="TransactionID2" Sum="-999999999999999999" OperationType="PULL" TransDateTime="0001-01-01T00:00:00+03:00" />
#     <TransInfo TransactionID="TransactionID3" Sum="999999999999999999" OperationType="RFND" TransDateTime="9999-12-31T23:59:59.9999999+03:00" />
#   </FPSTransInfo>
#   <FPSTransInfo BICCorr="BICCorr2" CorrespAcc="CorrespAcc2" DC="CRED">
#     <TransInfo TransactionID="TransactionID4" Sum="-1" OperationType="REPT" TransDateTime="1899-11-30T01:01:01+03:00" />
#     <TransInfo TransactionID="TransactionID5" Sum="1" OperationType="REPN" TransDateTime="1900-02-02T01:01:01+03:00" />
#     <TransInfo TransactionID="TransactionID6" Sum="-999999999999999998" OperationType="REPC" TransDateTime="0001-02-02T00:00:00+03:00" />
#   </FPSTransInfo>
#   <FPSTransInfo BICCorr="BICCorr3" CorrespAcc="CorrespAcc3" DC="DEBT">
#     <TransInfo TransactionID="TransactionID7" Sum="999999999999999998" OperationType="REPB" TransDateTime="9999-11-29T23:59:59.9999999+03:00" />
#     <TransInfo TransactionID="TransactionID8" Sum="-2" OperationType="PUSH" TransDateTime="1899-10-29T01:01:01+04:00" />
#     <TransInfo TransactionID="TransactionID9" Sum="2" OperationType="PULL" TransDateTime="1900-03-06T01:01:01+03:00" />
#   </FPSTransInfo>
#   <InitialED EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
# </ED743>
