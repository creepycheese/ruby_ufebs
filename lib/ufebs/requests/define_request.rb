module Ufebs
  module Requests
    class DefineRequest
      include HappyMapper
      include Ufebs::Fields::Header

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED243'
      namespace 'ed'

      attribute :ed_define_request_code, String, tag: 'EDDefineRequestCode'
      attribute :ed_define_request_text, String, tag: 'EDDefineRequestText'
      attribute :payer_name,             String, tag: 'PayerName'

      has_one :original_ed, Ufebs::Entities::EdRefId,
              tag: 'OriginalEPD'

      has_one :ed_define_request_info, Ufebs::Entities::EdDefineRequestInfo,
              tag: 'EdDefineRequestInfo'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :original_ed            then @trans_infos            = set_ed_ref_id(value)
          when :ed_define_request_info then @ed_define_request_info = set_ed_define_request_info(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def set_ed_define_request_info(value)
        Ufebs::Entities::EdDefineAnswerInfo.new(value)
      end

      def set_ed_ref_id(value)
        Ufebs::Entities::EdRefId.new(value)
      end
    end
  end
end

# <?xml version="1.0" encoding="utf-8"?>
#   <ED243 EDDefineRequestCode="EDDefineRequestCode1" EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">

# <PayerName>PayerName1</PayerName>
#     <PayeeName>PayeeName1</PayeeName>
# <EDDefineRequestText>EDDefineRequestText1</EDDefineRequestText>
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
# </EDDefineRequestInfo>
# </ED243>