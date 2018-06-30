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

      def initialize(params={})
        @number, @ed_date, @ed_author = params[:number], params[:ed_date], params[:ed_author]
        super()
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(:encoding => encoding)).to_xml
      end
    end
  end
end
