module Ufebs
  module Requests
    class PackageRequest
      class Ref
        include HappyMapper
        attribute :number, String, tag: 'EDNo'
        attribute :date, String, tag: 'EDDate'
        attribute :author, String, tag: 'EDAuthor'

        def initialize(number: '7', date: '2003-04-14', author: '4525545000')
          @number, @date, @author = number, date, author
        end
      end

      include HappyMapper
      include Ufebs::Fields::Header

      tag 'ED202'

      attribute :xmlns, String, tag: 'xmlns'
      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :ed_inqiery_code, String, tag: 'EDInquiryCode'
      has_one :ref, Ref, tag: 'EDRefID'

      def initialize(params = {})
        @ref = Ref.new(params[:ref])
        params.delete(:ref)

        params.each { |key, value| instance_variable_set("@#{key}".to_sym, value) }

        @xmlns = "urn:cbr-ru:ed:v2.0".freeze
      end
    end
  end
end

# <?xml version="1.0" encoding="WINDOWS-1251"?>
# <ED202 xmlns="urn:cbr-ru:ed:v2.0"
# EDNo="8" EDDate="2003-04-14" EDAuthor="4525545000" EDReceiver="4525000000" EDInquiryCode="1">
# <EDRefID EDNo="7" EDDate="2003-04-14" EDAuthor="4525545000" /> </ED202>
