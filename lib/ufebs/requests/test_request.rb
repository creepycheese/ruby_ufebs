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
      end
    end
  end
end
