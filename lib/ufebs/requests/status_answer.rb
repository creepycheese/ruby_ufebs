module Ufebs
  module Requests
    class StatusAnswer
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED205'
      namespace 'ed'

      attribute :ctrl_time,                 String, tag: 'CtrlTime'
      attribute :ed_author,                 String, tag: 'EDAuthor'
      attribute :ed_date,                   String, tag: 'EDDate'
      attribute :ed_no,                     String, tag: 'EDNo'
      attribute :ed_receiver,               String, tag: 'EDReceiver'
      attribute :status_state_code,         String, tag: 'StatusStateCode'

      has_one :ed_ref_id, ::Ufebs::Entities::EdRefId
      has_one :session, ::Ufebs::Entities::Session, tag: 'Session', state_when_nil: false
    end
  end
end

#<?xml version="1.0" encoding="WINDOWS-1251"?
#><ED205 CtrlTime="2018-02-27T10:36:13Z" EDAuthor="4583001999" EDDate="2018-02-23" EDNo="1066492" EDReceiver="4525420000" StatusStateCode="30" xmlns="urn:cbr-ru:ed:v2.0">
#<EDRefID EDAuthor="4525420000" EDDate="2018-02-23" EDNo="1"/><Session><SessionID>5</SessionID></Session></ED205>
