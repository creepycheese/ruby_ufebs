module Ufebs
  module Requests
    class TestRequest
      include HappyMapper

      tag 'ED999'
      namespace 'ed'

      attribute :number, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :xmlns, String, tag: 'xmlns'

      def initialize(params={})
        @number, @ed_date, @ed_author = params[:number], params[:ed_date], params[:ed_author]
        @xmlns = XMLNS
      end
    end
  end
end
