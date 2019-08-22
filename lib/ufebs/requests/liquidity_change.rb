module Ufebs
  module Requests
    class LiquidityChange
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"

      tag 'ED731'
      namespace 'ed'

      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'

      has_one :request_info, Ufebs::Entities::RequestInfo, tag: 'RequestInfo'
      has_one :request_reason, Ufebs::Entities::RequestReason, tag: 'RequestReason'
      has_one :ed_ref_id, Ufebs::Entities::EdRefId, tag: 'EDRefID'
      
      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :request_info then @request_info = Ufebs::Entities::RequestInfo.new(value)
          when :request_reason then @request_reason = Ufebs::Entities::RequestReason.new(value)
          when :ed_ref_id then @ed_ref_id = Ufebs::Entities::EdRefId.new(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(:encoding => encoding)).to_xml
      end
    end
  end
end

# <ED731 EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
#   <RequestInfo BIC="BIC1" CorrespAcc="CorrespAcc1" Sum="0" LiquidityTransKind="INCL" />
#   <RequestReason CreateReasonCode="ARRS" />
#   <EDRefID EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" />
# </ED731>
