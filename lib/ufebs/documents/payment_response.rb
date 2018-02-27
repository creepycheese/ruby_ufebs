module Ufebs
  module Documents
    class PaymentResponse
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      tag 'ED206'
      namespace 'ed'

      attribute :acc,                 String, tag: 'Acc'
      attribute :bic_corr,            String, tag: 'BICCorr'
      attribute :corr_acc,            String, tag: 'CorrAcc'
      attribute :dc,                  String, tag: 'DC'
      attribute :ed_author,           String, tag: 'EDAuthor'
      attribute :ed_date,             String, tag: 'EDDate'
      attribute :ed_no,               String, tag: 'EDNo'
      attribute :ed_receiver,         String, tag: 'EDReceiver'
      attribute :sum,                 String, tag: 'Sum'
      attribute :system_code,         String, tag: 'SystemCode'
      attribute :trans_date,          String, tag: 'TransDate'
      attribute :trans_time,          String, tag: 'TransTime'

      has_one :acc_doc, ::Ufebs::Entities::AccDoc,              tag: 'AccDoc'
      has_one :ed_ref_id, ::Ufebs::Entities::EdRefId,           tag: 'EDRefID'
      has_one :processing_details, ::Ufebs::Entities::ProcessingDetails, tag: 'ProcessingDetails'

      def initialize(params = {})
        params.each do |key, value|
          case key
          when :acc_doc
            @acc_doc = value.is_a?(Hash) ? ::Ufebs::Entities::AccDoc.new(value) : acc_doc
          when :ed_ref_id
            @ed_ref_id = value.is_a?(Hash) ? ::Ufebs::Entities::EdRefId.new(value) : acc_doc
          when :processing_details
            @processing_details = value.is_a?(Hash) ? ::Ufebs::Entities::ProcessingDetails.new(value) : acc_doc
          else instance_variable_set("@#{key}".to_sym, value)
          end

          super()
        end
      end
    end
  end
end
#   <ED206 Acc="30101810945250000420" 
#   BICCorr="044525000" 
#   CorrAcc="40101810045250010041" 
#   DC="1" EDAuthor="4583001999" 
#   EDDate="2018-02-23" EDNo="1070232" 
#   EDReceiver="4525420000" Sum="680700" 
#   SystemCode="01" 
#   TransDate="2018-02-23" 
#   TransTime="13:33:08">
#     <AccDoc AccDocDate="2018-02-23" AccDocNo="459"/>
#     <EDRefID EDAuthor="4525420000" EDDate="2018-02-23" EDNo="7"/>
#     <ProcessingDetails CreditDate="2018-02-23" DebitDate="2018-02-23"/>
#   </ED206>
