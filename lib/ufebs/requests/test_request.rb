module Ufebs
  module Requests
    class TestRequest
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"

      tag 'ED999'
      namespace 'ed'

      attribute :number, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :creation_date_time, String, tag: 'CreationDateTime'

      def initialize(params={})
        @number, @ed_date, @ed_author = params[:number], params[:ed_date], params[:ed_author]
        @creation_date_time = DateTime.parse(params[:creation_date_time].to_s).strftime("%Y-%m-%dT%H:%M:%SZ")
        super()
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(:encoding => encoding)).to_xml
      end
    end
  end
end
