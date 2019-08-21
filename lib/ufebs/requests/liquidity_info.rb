module Ufebs
  module Requests
    class LiquidityInfo
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"

      tag 'ED710'
      namespace 'ed'

      def initialize
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(:encoding => encoding)).to_xml
      end
    end
  end
end

# <ED710 EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
#   <BICAccount BIC="BIC1" CorrespAcc="CorrespAcc1" />
# </ED710>
