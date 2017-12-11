module Ufebs
  module Fields
    module Header
      def self.included(content)
        content.attribute :number, String, tag: 'EDNo'
        content.attribute :ed_date, String, tag: 'EDDate'
        content.attribute :ed_author, String, tag: 'EDAuthor'
        content.attribute :ed_receiver, String, tag: 'EDReceiver'
      end
    end
  end
end