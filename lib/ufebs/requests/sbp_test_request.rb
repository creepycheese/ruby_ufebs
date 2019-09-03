module Ufebs
  module Requests
    class SbpTestRequest
      include HappyMapper

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'

      tag 'ED799'
      namespace 'ed'

      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :creation_date_time, String, tag: 'CreationDateTime'

      def initialize(params = {})
        @ed_no = params[:ed_no]
        @ed_author = params[:ed_author]
        @ed_date = Date.parse(params[:ed_date].to_s).strftime('%Y-%m-%d')
        @creation_date_time = DateTime.parse(params[:creation_date_time].to_s).strftime("%Y-%m-%dT%H:%M:%SZ")
        super()
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(encoding: encoding)).to_xml
      end
    end
  end
end
