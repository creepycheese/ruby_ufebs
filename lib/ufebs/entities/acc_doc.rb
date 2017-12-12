module Ufebs
  module Entities
    class AccDoc
      include HappyMapper
      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      attribute :number, String, tag: 'AccDocNo'
      attribute :date, String, tag: 'AccDocDate'

      def initialize(number:'', date: Time.now)
        @number, @date = number.to_s.rjust(3,'0'), Date.parse(date.to_s).strftime('%Y-%m-%d')
      end
    end
  end
end
