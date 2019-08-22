module Ufebs
  module Requests
    class ParticipantProfile
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"

      tag 'ED806'
      namespace 'ed'

      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :request_code, String, tag: 'RequestCode'

      has_one :participant_id, Ufebs::Entities::ParticipantId, tag: 'ParticipantID'

      def initialize(params={})
        params.each do |key, value|
          case key.to_sym
          when :ed_date then @ed_date = Date.parse(value.to_s).strftime('%Y-%m-%d')
          when :participant_id then @bic_account = Ufebs::Entities::ParticipantId.new(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(encoding: encoding)).to_xml
      end
    end
  end
end

# <ED806 RequestCode="FIRR" EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
#   <ParticipantID>
#     <BIC>BIC1</BIC>
#   </ParticipantID>
# </ED806>
