module Ufebs
  module Requests
    class LiquidityInfo
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"

      tag 'ED742'
      namespace 'ed'

      def initialize
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(:encoding => encoding)).to_xml
      end
    end
  end
end

# <ED742 EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
#   <RequestInfo BIC="BIC1" CorrespAcc="CorrespAcc1">
#     <DateTimeInterval BeginTime="1900-01-01T01:01:01+03:00" EndTime="1900-01-01T01:01:01+03:00" />
#   </RequestInfo>
# </ED742>
