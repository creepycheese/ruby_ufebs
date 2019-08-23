# frozen_string_literal: true

module Ufebs
  module Requests
    class GetRegistry
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"

      tag 'ED742'
      namespace 'ed'

      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'

      has_one :request_info, Ufebs::Entities::RequestInfo, tag: 'RequestInfo'

      def initialize(params={})
        params.each do |key, value|
          case key.to_sym
          when :ed_date then @ed_date = Date.parse(value.to_s).strftime('%Y-%m-%d')
          when :request_info then @request_info = Ufebs::Entities::RequestInfo.new(value)
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

# <ED742 EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
#   <RequestInfo BIC="BIC1" CorrespAcc="CorrespAcc1">
#     <DateTimeInterval BeginTime="1900-01-01T01:01:01+03:00" EndTime="1900-01-01T01:01:01+03:00" />
#   </RequestInfo>
# </ED742>
