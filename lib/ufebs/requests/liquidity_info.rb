module Ufebs
  module Requests
    class LiquidityInfo
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"

      tag 'ED710'
      namespace 'ed'

      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      
      has_one :bic_account, Ufebs::Entities::BicAccount, tag: 'BICAccount'
      
      def initialize(params={})
        params.each do |key, value|
          case key.to_sym
          when :bic_account then @bic_account = Ufebs::Entities::BicAccount.new(value)
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

# <ED710 EDReceiver="EDReceiver1" EDNo="1" EDDate="1900-01-01" EDAuthor="EDAuthor1" xmlns="urn:cbr-ru:ed:v2.0">
#   <BICAccount BIC="BIC1" CorrespAcc="CorrespAcc1" />
# </ED710>
