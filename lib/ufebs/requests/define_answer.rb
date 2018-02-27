module Ufebs
  module Requests
    class DefineAnswer
      include HappyMapper
      include Ufebs::Fields::Header

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED244'
      namespace 'ed'

      attribute :ed_define_request_code, String, tag: 'EDDefineRequestCode'
      attribute :ed_define_answer_code,  String, tag: 'EDDefineAnswerCode'

      has_one :original_epd, Ufebs::Entities::EdRefId,
              tag: 'OriginalEPD'

      has_one :ed_define_answer_info, Ufebs::Entities::EdDefineAnswerInfo,
              tag: 'EDDefineAnswerInfo'

      has_one :initial_ed, Ufebs::Entities::EdRefId,
              tag: 'InitialED'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :ed_define_answer_info then set_ed_define_answer_info(value)
          when :original_epd          then set_original_epd(value)
          when :initial_ed            then set_initial_ed(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def set_ed_define_answer_info(value)
        @ed_define_answer_info = Ufebs::Entities::EdDefineAnswerInfo.new(value)
      end

      def set_original_epd(value)
        @original_epd = Ufebs::Entities::EdRefId.new(value)
      end

      def set_initial_ed(value)
        @initial_ed = Ufebs::Entities::EdRefId.new(value)
      end
    end
  end
end

# <?xml version="1.0" encoding="utf-8"?>
#   <ED244 EDDefineRequestCode="EDDefineRequestCode1" EDDefineAnswerCode="EDDefineAnswerCode1" EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
# <OriginalEPD EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
# <EDDefineAnswerInfo AccDocDate="1900-01-01" AccDocNo="AccDo1" PayerAcc="PayerAcc1" PayeeAcc="PayeeAcc1" PayerINN="PayerINN1" PayeeINN="PayeeINN1" Sum="1" EnterDate="1900-01-01" PayeeCorrAcc="PayeeCorrAcc1" PayeeBIC="PayeeBIC1">
# <PayerLongName>PayerLongName1</PayerLongName>
#     <PayeeLongName>PayeeLongName1</PayeeLongName>
# <Purpose>Purpose1</Purpose>
#     <Address>Address1</Address>
# <EDDefineAnswerText>EDDefineAnswerText1</EDDefineAnswerText>
#     <EDFieldList>
#       <FieldNo>FieldNo1</FieldNo>
# <FieldValue>FieldValue1</FieldValue>
#     </EDFieldList>
# <EDFieldList>
# <FieldNo>FieldNo2</FieldNo>
#       <FieldValue>FieldValue2</FieldValue>
# </EDFieldList>
#     <EDFieldList>
#       <FieldNo>FieldNo3</FieldNo>
# <FieldValue>FieldValue3</FieldValue>
#     </EDFieldList>
# <EDReestrInfo TransactionID="1">
# <EDReestrFieldList>
# <FieldNo>FieldNo1</FieldNo>
#         <FieldValue>FieldValue1</FieldValue>
# </EDReestrFieldList>
#       <EDReestrFieldList>
#         <FieldNo>FieldNo2</FieldNo>
# <FieldValue>FieldValue2</FieldValue>
#       </EDReestrFieldList>
# <EDReestrFieldList>
# <FieldNo>FieldNo3</FieldNo>
#         <FieldValue>FieldValue3</FieldValue>
# </EDReestrFieldList>
#     </EDReestrInfo>
# <EDReestrInfo TransactionID="-99999">
# <EDReestrFieldList>
# <FieldNo>FieldNo4</FieldNo>
#         <FieldValue>FieldValue4</FieldValue>
# </EDReestrFieldList>
#       <EDReestrFieldList>
#         <FieldNo>FieldNo5</FieldNo>
# <FieldValue>FieldValue5</FieldValue>
#       </EDReestrFieldList>
# <EDReestrFieldList>
# <FieldNo>FieldNo6</FieldNo>
#         <FieldValue>FieldValue6</FieldValue>
# </EDReestrFieldList>
#     </EDReestrInfo>
# <EDReestrInfo TransactionID="99999">
# <EDReestrFieldList>
# <FieldNo>FieldNo7</FieldNo>
#         <FieldValue>FieldValue7</FieldValue>
# </EDReestrFieldList>
#       <EDReestrFieldList>
#         <FieldNo>FieldNo8</FieldNo>
# <FieldValue>FieldValue8</FieldValue>
#       </EDReestrFieldList>
# <EDReestrFieldList>
# <FieldNo>FieldNo9</FieldNo>
#         <FieldValue>FieldValue9</FieldValue>
# </EDReestrFieldList>
#     </EDReestrInfo>
# </EDDefineAnswerInfo>
#   <InitialED EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
# </ED244>
