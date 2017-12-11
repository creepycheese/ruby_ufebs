module Ufebs
  module Requests
    class GroupRequest
      include HappyMapper
      include Fields::Header

      tag 'ED203'

      attribute :xmlns, String, tag: 'xmlns'
      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :status_code, String, tag: 'StatusCode'
      attribute :account, String, tag: 'Acc'
      attribute :group_inquiry_code, String, tag: 'GroupInquiryCode'

      def initialize(params = {})

        params.each { |key, value| instance_variable_set("@#{key}".to_sym, value) }
        @xmlns = "urn:cbr-ru:ed:v2.0".freeze
      end
    end
  end
end


# <?xml version="1.0" encoding="WINDOWS-1251"?>
# <ED203 xmlns="urn:cbr-ru:ed:v2.0"
# EDNo="9" EDDate="2003-04-14" EDAuthor="4525545000" EDReceiver="4525000000" StatusCode="00" Acc="30101810300000000545" GroupInquiryCode="1"/>
